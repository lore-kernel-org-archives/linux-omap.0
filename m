From: "K S Shankar" <sshanmugam@ciber.com>
Subject: encoder audio or speech for omap5912
Date: Fri, 6 Oct 2006 17:29:01 +0530
Message-ID: <002e01c6e93e$d27fe8c0$5a4517ac@CibersiteIndia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi All, 
 
I want encode wav to mp3 on omap5912. I try to compiled lame3.97 with
montavista linux cross compiler with options 
CC= /opt/montavista/previewkit/arm/v4t_le/bin/arm_v4t_le-gcc ./configure
--target=arm-linux --host=arm-linux --prefix=/root/lame. 
This compiled properly, but not works.  
 
/ # lame
LAME version 3.97 (http://lame.sourceforge.net/)
 
usage: lame [options] <infile> [outfile]
 
    <infile> and/or <outfile> can be "-", which means stdin/stdout.
 
Try:
     "lame --help"           for general usage information
 or:
     "lame --preset help"    for information on suggested predefined
settings
 or:
     "lame --longhelp"
  or "lame -?"              for a complete options list
/home # lame testcase.wav testcase.mp3
Segmentation fault.
 
I think that the problem maybe with this(configure warning)
 
checking for IEEE854 compliant 80 bit floats... configure: WARNING: can't
check for IEEE854 compliant 80 bit floats
 
checking for ieee754_float64_t... no
checking for ieee754_float32_t... no
configure: WARNING:
  **************************************************************************
  *                                                                        *
  * You are cross compiling:                                               *
  *   - I did not have a change to determine                               *
  *     + the size of:                                                     *
  *       - short                                                          *
  *       - unsigned short                                                 *
  *       - int                                                            *
  *       - unsigned int                                                   *
  *       - long                                                           *
  *       - unsigned long                                                  *
  *       - float                                                          *
  *       - double                                                         *
  *       - long double                                                    *
  *     + the endianess of the system                                      *
  *   - You have to provide appropriate defines for them in config.h, e.g. *
  *     + define SIZEOF_SHORT to 2 if the size of a short is 2             *
  *     + define WORDS_BIGENDIAN if your system is a big endian system     *
  *                                                                        *
  **************************************************************************
 
Anyone could help me with this.

 

 

Thanks & Regards,

K. S. Shankar

 
