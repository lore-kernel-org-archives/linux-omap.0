From: Prashant <prashantkhoje@gmail.com>
Subject: OMAP1710 H3: full duplex audio problem
Date: Mon, 11 Sep 2006 16:03:07 +0530
Message-ID: <7b1b9c8b0609110333w565de1dckf47d5bfe982c24d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi All,

I am trying to use audio on omap1710 h3 in full duplex mode. I am
using ES2.0 board and linux kernel 2.6.10.
I came across following errors during the process:

1] omap_dma: You need to stop the DMA channels before unlinking

2] {audio_process_dma}-ERROR: Called again while In Use

3] {audio_dsr_handler}-ERROR: Interrupt(3)  for empty queue(h=1, T=1)???
    {audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607
    {audio_dsr_handler}-ERROR: Interrupt(2)  for empty queue(h=1, T=1)???
    {audio_dsr_handler}-ERROR: nbfrag=1024,pendfrags=18,USR-H=625, QH-607 QT-607


I applied some patches found on this list to tackle these errors:
- patch at http://linux.omap.com/pipermail/linux-omap-open-source/2005-May/003997.html
for error 1] above
- patch at http://linux.omap.com/pipermail/linux-omap-open-source/2005-February/002997.html
for error 3] above

I still get error 2] & 3] sometimes.

I tried to get loopback working; but I get repetitive noise only. It
gets louder over time.

Here's my test code:

#include <stdio.h>
#include <stdlib.h>
#include <linux/soundcard.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <errno.h>


#define DEVICE_NAME ("/dev/sound/dsp")

#define AUDIO_BUFFER_SIZE    (256 * 16)

#define SAMPLING_RATE        ( 8000 )     /* 8000, 16000, 44100, 48000 Hz */
#define NO_OF_AUDIO_CHANNELS ( 2 )
#define FRAGMENT_SIZE        ( 0x00100008 )

int main(void)
{
    int caps, fragment_size, fmt, channel_count, sampling_rate;

    int audio_fd;

    int data_length;
    char *data_ptr, *data_ptr2;

/* open device */
    audio_fd = open (DEVICE_NAME, O_RDWR, 0);
    if ( audio_fd == -1 )
    {
        /* device open failed */
        perror( DEVICE_NAME );
        exit( 1 );
    }

/* set full duplex mode */
    if(ioctl(audio_fd, SNDCTL_DSP_SETDUPLEX, 0) < 0)
    {
	perror ( "SNDCTL_DSP_SETDUPLEX" );
        exit ( 1 );
    }

    if (ioctl(audio_fd, SNDCTL_DSP_GETCAPS, &caps) < 0)
    {
	perror ( "SNDCTL_DSP_GETCAPS" );
        exit ( 1 );
    }

    if(DSP_CAP_DUPLEX & caps)
    {
	printf("\nFull Duplex Supported \n");
    }
    printf("\ncapibilities ~ 0x%x\n", caps);


/* set fragment size */
    fragment_size = FRAGMENT_SIZE;

    if( ioctl( audio_fd, SNDCTL_DSP_SETFRAGMENT, &fragment_size ) < 0 )
    {
        perror ( "SNDCTL_DSP_SETFRAGMENT" );
	exit ( 1 );
    }

    /* check it fragment size. */
    if( ioctl( audio_fd, SNDCTL_DSP_GETBLKSIZE, &fragment_size ) < 0 )
    {
        perror( "SNDCTL_DSP_GETBLKSIZE" );
	exit ( 1 );
    }

    if ( (2 << ((FRAGMENT_SIZE & 0x0000FFFF) - 1)) != fragment_size)
    {
        printf( "\n fragment size being used ~ %d, requested %d\n",
        		fragment_size, (2<<((FRAGMENT_SIZE & 0x0000FFFF)-1)));
        exit ( 0 );
    }



/* set format */
    fmt = AFMT_S16_NE;
    if( ioctl( audio_fd, SNDCTL_DSP_SETFMT, &fmt ) < 0 )
    {
        /* fatal error */
        perror ( "SNDCTL_DSP_SETFMT" );
	exit( 1 );
    }

    if ( AFMT_S16_NE != fmt )
    {
        printf ("\nThe devic doesnt support AFMT_S16_NE format. Format
set to %d.\n", fmt);
        exit( 1 );
    }


/* set no of channels */
    channel_count = NO_OF_AUDIO_CHANNELS;

    if( ioctl( audio_fd, SNDCTL_DSP_CHANNELS, &channel_count ) == -1 )
    {
        /* fatal error */
        perror ( "SNDCTL_DSP_CHANNELS" );
        exit( 1 );
    }

    if ( NO_OF_AUDIO_CHANNELS != channel_count )
    {
        printf ("\nThe devic doesnt support requested number of
channels. Number of Channels set to %d.\n", channel_count);
        exit( 1 );
    }



/* set sampling rate */
    sampling_rate = SAMPLING_RATE;

    if( ioctl( audio_fd, SNDCTL_DSP_SPEED, &sampling_rate ) == -1 )
    {
        /* fatal error */
        perror ( "SNDCTL_DSP_SPEED" );
        exit( 1 );
    }

    if ( SAMPLING_RATE != sampling_rate )
    {
        printf ("\nThe devic doesnt support requested sampling rate.
Sampling rate set to %d.\n", sampling_rate );
        exit( 1 );
    }


    data_ptr  = (char *) calloc( 1, AUDIO_BUFFER_SIZE );
    data_ptr2 = (char *) calloc( 1, AUDIO_BUFFER_SIZE );

    if (data_ptr == NULL || data_ptr2 == NULL)
    {
	printf ("\ndata allocation failed");
	exit ( 1 );
   }


   while (1)
   {
        data_length = read( audio_fd, data_ptr, fragment_size );
        if ( -1 == data_length )
        {
            perror ( " audio read " );
            exit ( 1 );
        }

        if ( data_length != fragment_size )
        {
            printf ( "\nshort read: %d\n", data_length );
        }

        if ( data_length > 0 )
        {
            memcpy ( data_ptr2, data_ptr, data_length );

            data_length = write( audio_fd, data_ptr2, data_length );
	    if ( -1 == data_length )
	    {
		perror ( " audio write " );
		exit ( 1 );
	   }

        }

   }

   free ( data_ptr );
   free ( data_ptr2 );

    if( audio_fd > 0 )
	close( audio_fd );

   return ( 0 );
}


Thank you,
Prashant Khoje
