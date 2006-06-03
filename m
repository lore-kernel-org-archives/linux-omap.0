From: =?gb2312?B?wdYgs6+4uw==?= <linchaofu@hotmail.com>
Subject: problem on tlv320aic23 in osk5912 using dspgateway3.3
Date: Sat, 03 Jun 2006 14:01:58 +0800
Message-ID: <BAY114-F23B294D2A16FF0B9A0382B2960@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all:
     i want to use dspgateway3.3(kernel2.6.12) to develop a=20
application,which sample some data through  tlv320aic23 in osk5912 dsp=20
side, then sent data to arm for process using dspgateway3.3.
for test, i sample some mp3 data played in pc,and sent it to tlv320aic23 =
to=20
replay in dsp side (using SIO stream to iuuse full buffer data). but no=20
sound output in headphone port!!why??but have some data sent by dsp to ar=
m=20
side!!
    my c files as below:
1 arm side:
#include <linux/soundcard.h>
#define CODEC_DEV "/dev/dsp"
/* Audio data Stereo (L and R) and 16 bits/sample */
#define STEREO          2
#define BITSPERSAMPLE  16

int codecFd =3D 0;

static void configureCodec( int sampleFreq )
{
    int ioctlarg;   =20

    /* Open the codec */
    codecFd =3D open( CODEC_DEV, O_WRONLY, 0 );

    if( codecFd =3D=3D -1 )=20
    {
		  printf("Error: Failed to open audio driver\n");
    }
    /* Configure the bits/sample in the driver */
    ioctlarg =3D BITSPERSAMPLE;=20

    if( ioctl(codecFd, SNDCTL_DSP_SETFMT, &ioctlarg) =3D=3D -1 )=20
    {
		printf("Error: cannot set bits\n");
    }

    /* Configure the number of audio channels in the data stream */
    ioctlarg =3D STEREO;    // AIC23 is a stereo codec

    if( ioctl(codecFd, SNDCTL_DSP_CHANNELS, &ioctlarg) =3D=3D -1 )=20
    {
		printf("Error: cannot set channels\n");
    }

    /* Configure the speed of the data stream */
    ioctlarg =3D sampleFreq;

    if( ioctl(codecFd, SNDCTL_DSP_SPEED, &ioctlarg) =3D=3D -1 )=20
    {
		printf("Error: cannot set speed\n");
    }
    return;
};
...
...
main()
{
char *devfn =3D "/dev/dsptask/tfad_adctask";
	int fd;
	int sampleFreq =3D 44100;
=09
	configureCodec(sampleFreq);
   =20
	fd =3D open(devfn, O_RDWR);
	if (fd < 0)=20
	{
		fprintf(stderr, "cannot open %s\n", devfn);
		return 1;
	}
=09
	write(fd, &cmd, 2);

	for (;;)=20
	{}
}


2 DSP side:
   i use  these libs(osk5912_dma_aic23_cslv3.l55l,=20
c5912_dma_mcbsp_cslv3.l55l, csl_OMAP5912.lib),that is the aic23 mini-driv=
er=20
in dsp side.

#include <std.h>
#include "mailbox.h"
#include "tokliBIOS.h"
#include <mem.h>
#include <sio.h>

#define BUFSIZE 128
#define BUFALIGN 1
/*static Uns bkdata[128];*/

SIO_Handle instream;
SIO_Handle outstream;
=09
static Void busywait(LgUns cnt)
{
	LgUns i;
	for (i =3D 0; i < cnt; i++) {}
}

static Uns aic23_init(struct dsptask *task)
{
	Ptr inbuf0;
	Ptr inbuf1;
	Ptr outbuf0;
	Ptr outbuf1;

	SIO_Attrs sio_attrs =3D SIO_ATTRS;
	sio_attrs       =3D SIO_ATTRS;=20
	sio_attrs.align =3D BUFALIGN;=20
          sio_attrs.model =3D SIO_ISSUERECLAIM;
          sio_attrs.nbufs =3D 2;
=09
	inbuf0 =3D (Ptr)MEM_calloc(0, BUFSIZE, BUFALIGN);
	inbuf1 =3D (Ptr)MEM_calloc(0, BUFSIZE, BUFALIGN);
	outbuf0 =3D (Ptr)MEM_calloc(0, BUFSIZE, BUFALIGN);
	outbuf1 =3D (Ptr)MEM_calloc(0, BUFSIZE, BUFALIGN);
=09
	instream =3D SIO_create("/dioCodec", SIO_INPUT, BUFSIZE, &sio_attrs);
	outstream =3D SIO_create("/dioCodec", SIO_OUTPUT, BUFSIZE, &sio_attrs);
=09
	if ( instream =3D=3D NULL)
	{
		dbg(task,"instream failured\n ");
	}
	if ( outstream =3D=3D NULL)
	{
		dbg(task,"outstream failured\n ");
	}
=09
	if (SIO_issue(instream, inbuf0, SIO_bufsize(instream), NULL) !=3D SYS_OK=
)
	{
        dbg(task,"Error issuing buffer to the input stream\n");
    }
    if (SIO_issue(instream, inbuf1, SIO_bufsize(instream), NULL) !=3D SYS=
_OK)
	{
        dbg(task,"Error issuing buffer to the input stream\n");
    }

	if (SIO_issue(outstream, outbuf0, SIO_bufsize(outstream), NULL) !=3D SYS=
_OK)
	{
        dbg(task,"Error issuing buffer to the output stream\n");
    }
    if (SIO_issue(outstream, outbuf1, SIO_bufsize(outstream), NULL) !=3D=20
SYS_OK)
	{
        dbg(task,"Error issuing buffer to the output stream\n");
    }
=09
	busywait(100000);
	return 0;
}
static Uns tfad_adctask_rcv_wdsnd(struct dsptask *task, Uns cmd)
{
	int nmadus, i;
	unsigned short * inbuf;
	unsigned short * outbuf;

    for (;;)=20
    {
       // if ( SIO_ready(instream) )
      	{
      	   /* Reclaim full buffer from the input stream */
     	   if ((nmadus =3D SIO_reclaim(instream, (Ptr *)&inbuf, NULL)) < 0)=
=20
     	   {
     	       dbg(task,"Error reclaiming full buffer from the input=20
stream\n");
    	   }
    	   if (SIO_reclaim(outstream, (Ptr *)&outbuf, NULL) < 0)=20
    	   {
           		dbg(task,"Error reclaiming empty buffer from the output=20
stream");
           }

           /* Do the data move. */
          for (i =3D 0; i < (nmadus / sizeof(short)); i++)=20
           {
            	outbuf[i] =3D inbuf[i];
           }
        =20
    	 /* Issue full buffer to the output stream */
           if (SIO_issue(outstream, outbuf, nmadus, NULL) !=3D SYS_OK)=20
           {
            	dbg(task,"Error issuing full buffer to the output stream");
           }
          =20
      	   /* Issue an empty buffer to the input stream */
      	   if (SIO_issue(instream, inbuf, SIO_bufsize(instream), NULL) !=3D=
=20
SYS_OK)
      	   {
      		  dbg(task,"Error issuing empty buffer to the input stream\n");
      	   }
    	}
    }=09

    return 0;

}

static Uns tfad_adctask_rcv_tctl(struct dsptask *task, Uns ctlcmd, Uns=20
*ret, Uns arg)
{
	switch (ctlcmd)=20
	{
		case MBCMD_TCTL_TINIT:
			aic23_init(task);
			return 0;
		default:
			return MBCMD_EID_BADTCTL;
	}
}

#pragma DATA_SECTION(tfad_adctask, "dspgw_task")
struct dsptask tfad_adctask =3D {
		TID_MAGIC,   =20
		"tfad_adctask",  =20
	    MBCMD_TTYP_BKDM | MBCMD_TTYP_BKMD |
	    MBCMD_TTYP_ASND | MBCMD_TTYP_PRCV,=09
		tfad_adctask_rcv_wdsnd,	   =20
	             NULL,		        =20
		tfad_adctask_rcv_tctl,
                      NULL	=09
		NULL,		           =20
		NULL		           =20
};
=20

when run the task, why no sound heard in the headphone port!?

Please provide solutions for my queries.

Thanks in advance,
lam

_________________________________________________________________
=C3=E2=B7=D1=CF=C2=D4=D8 MSN Explorer:   http://explorer.msn.com/lccn =20
