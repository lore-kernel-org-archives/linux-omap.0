From: "balaji  narayanam" <narayanamb@rediffmail.com>
Subject: Interfacing the OV7620 with OSK5912
Date: 21 Jul 2007 11:50:07 -0000
Message-ID: <20070721115007.21049.qmail@f5mail13.rediffmail.com>
Reply-To: balaji narayanam <narayanamb@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

  =0AHi,=0A=0AI am trying to Interface the OV7620 Image sensor to the Expan=
sion connector C port of OSK5912.=0AFor this I made a PCB to connect the Im=
age sensor to the Expansion Connector C port Pins.=0A=0AFor building the uI=
mage I had chosen the kernel options in the make menuconfig for I2C AND V4L=
.=0AI compiled a cprogram v4lgrab.c  and executed ./v4lgrabv executable  in=
 the OSK5912=0AI am getting the following error in the OSK=0A# ./v4lgrabv=
=0A/dev/video0: No such device=0A=0AI am herewith giving the v4lgrab.c prog=
ram=0A/* Simple Video4Linux image grabber. */=0A/*=0A *	Video4Linux Driver =
Test/Example Framegrabbing Program=0A *=0A *	Compile with:=0A *		gcc -s -Wa=
ll -Wstrict-prototypes v4lgrab.c -o v4lgrab=0A *      Use as:=0A *         =
     v4lgrab >image.ppm=0A *=0A *	Copyright (C) 1998-05-03, Phil Blundell <=
philb@gnu.org>=0A *      Copied from http://www.tazenda.demon.co.uk/phil/vg=
rabber.c=0A *      with minor modifications (Dave Forrest, drf5n@virginia.e=
du).=0A *=0A */=0A=0A#include <unistd.h>=0A#include <sys/types.h>=0A#includ=
e <sys/stat.h>=0A#include <fcntl.h>=0A#include <stdio.h>=0A#include <sys/io=
ctl.h>=0A#include <stdlib.h>=0A=0A#include <linux/types.h>=0A#include <linu=
x/videodev.h>=0A=0A#define FILE "/dev/video0"=0A=0A/* Stole this from tvset=
.c */=0A=0A#define READ_VIDEO_PIXEL(buf, format, depth, r, g, b)           =
        \=0A{                                                              =
         \=0A	switch (format)                                              =
   \=0A	{                                                               \=
=0A		case VIDEO_PALETTE_GREY:                                \=0A			switch =
(depth)                                  \=0A			{                          =
                     \=0A				case 4:                                 \=0A		=
		case 6:                                 \=0A				case 8:                  =
               \=0A					(r) =3D (g) =3D (b) =3D (*buf++ << 8);\=0A					brea=
k;                          \=0A									\=0A				case 16:                  =
              \=0A					(r) =3D (g) =3D (b) =3D               \=0A						*((u=
nsigned short *) buf);      \=0A					buf +=3D 2;                       \=0A=
					break;                          \=0A			}                              =
                 \=0A			break;                                          \=
=0A									\=0A									\=0A		case VIDEO_PALETTE_RGB565:                  =
            \=0A		{                                                       \=
=0A			unsigned short tmp =3D *(unsigned short *)buf;    \=0A			(r) =3D tmp&=
0xF800;                               \=0A			(g) =3D (tmp<<5)&0xFC00;      =
                    \=0A			(b) =3D (tmp<<11)&0xF800;                       =
  \=0A			buf +=3D 2;                                       \=0A		}         =
                                              \=0A		break;                 =
                                 \=0A									\=0A		case VIDEO_PALETTE_RGB5=
55:                              \=0A			(r) =3D (buf[0]&0xF8)<<8;          =
               \=0A			(g) =3D ((buf[0] << 5 | buf[1] >> 3)&0xF8)<<8;    \=
=0A			(b) =3D ((buf[1] << 2 ) & 0xF8)<<8;               \=0A			buf +=3D 2; =
                                      \=0A			break;                        =
                  \=0A									\=0A		case VIDEO_PALETTE_RGB24:             =
                  \=0A			(r) =3D buf[0] << 8; (g) =3D buf[1] << 8;         =
  \=0A			(b) =3D buf[2] << 8;                              \=0A			buf +=3D =
3;                                       \=0A			break;                     =
                     \=0A									\=0A		default:                           =
                     \=0A			fprintf(stderr,                                =
 \=0A				"Format %d not yet supported\n",        \=0A				format);          =
                      \=0A	}                                               =
                \=0A}=0A=0Aint get_brightness_adj(unsigned char *image, lon=
g size, int *brightness) {=0A  long i, tot =3D 0;=0A  for (i=3D0;i<size*3;i=
++)=0A    tot +=3D image[i];=0A  *brightness =3D (128 - tot/(size*3))/3;=0A=
  return !((tot/(size*3)) >=3D 126 && (tot/(size*3)) <=3D 130);=0A}=0A=0Ain=
t main(int argc, char ** argv)=0A{=0A  int fd =3D open(FILE, O_RDONLY), f;=
=0A  struct video_capability cap;=0A  struct video_window win;=0A  struct v=
ideo_picture vpic;=0A=0A  unsigned char *buffer, *src;=0A  int bpp =3D 24, =
r, g, b;=0A  unsigned int i, src_depth;=0A=0A  if (fd < 0) {=0A    perror(F=
ILE);=0A    exit(1);=0A  }=0A=0A  if (ioctl(fd, VIDIOCGCAP, &cap) < 0) {=0A=
    perror("VIDIOGCAP");=0A    fprintf(stderr, "(" FILE " not a video4linux=
 device?)\n");=0A    close(fd);=0A    exit(1);=0A  }=0A=0A  if (ioctl(fd, V=
IDIOCGWIN, &win) < 0) {=0A    perror("VIDIOCGWIN");=0A    close(fd);=0A    =
exit(1);=0A  }=0A=0A  if (ioctl(fd, VIDIOCGPICT, &vpic) < 0) {=0A    perror=
("VIDIOCGPICT");=0A    close(fd);=0A    exit(1);=0A  }=0A=0A  if (cap.type =
& VID_TYPE_MONOCHROME) {=0A    vpic.depth=3D8;=0A    vpic.palette=3DVIDEO_P=
ALETTE_GREY;    /* 8bit grey */=0A    if(ioctl(fd, VIDIOCSPICT, &vpic) < 0)=
 {=0A      vpic.depth=3D6;=0A      if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {=
=0A	vpic.depth=3D4;=0A	if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {=0A	  fprintf=
(stderr, "Unable to find a supported capture format.\n");=0A	  close(fd);=
=0A	  exit(1);=0A	}=0A      }=0A    }=0A  } else {=0A    vpic.depth=3D24;=
=0A    vpic.palette=3DVIDEO_PALETTE_RGB24;=0A=0A    if(ioctl(fd, VIDIOCSPIC=
T, &vpic) < 0) {=0A      vpic.palette=3DVIDEO_PALETTE_RGB565;=0A      vpic.=
depth=3D16;=0A=0A      if(ioctl(fd, VIDIOCSPICT, &vpic)=3D=3D-1) {=0A	vpic.=
palette=3DVIDEO_PALETTE_RGB555;=0A	vpic.depth=3D15;=0A=0A	if(ioctl(fd, VIDI=
OCSPICT, &vpic)=3D=3D-1) {=0A	  fprintf(stderr, "Unable to find a supported=
 capture format.\n");=0A	  return -1;=0A	}=0A      }=0A    }=0A  }=0A=0A  b=
uffer =3D malloc(win.width * win.height * bpp);=0A  if (!buffer) {=0A    fp=
rintf(stderr, "Out of memory.\n");=0A    exit(1);=0A  }=0A=0A  do {=0A    i=
nt newbright;=0A    read(fd, buffer, win.width * win.height * bpp);=0A    f=
 =3D get_brightness_adj(buffer, win.width * win.height, &newbright);=0A    =
if (f) {=0A      vpic.brightness +=3D (newbright << 8);=0A      if(ioctl(fd=
, VIDIOCSPICT, &vpic)=3D=3D-1) {=0A	perror("VIDIOSPICT");=0A	break;=0A     =
 }=0A    }=0A  } while (f);=0A=0A  fprintf(stdout, "P6\n%d %d 255\n", win.w=
idth, win.height);=0A=0A  src =3D buffer;=0A=0A  for (i =3D 0; i < win.widt=
h * win.height; i++) {=0A    READ_VIDEO_PIXEL(src, vpic.palette, src_depth,=
 r, g, b);=0A    fputc(r>>8, stdout);=0A    fputc(g>>8, stdout);=0A    fput=
c(b>>8, stdout);=0A  }=0A=0A  close(fd);=0A  return 0;=0A}=0A=0APlease help=
=0A=0ABalaji.N=0A=0A=0A=0A=0A
