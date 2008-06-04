From: "mohammed shareef" <mdshareef@gmail.com>
Subject: microwindows gives error
Date: Wed, 4 Jun 2008 16:47:26 +0530
Message-ID: <a1d91fa0806040417n46e68fcav641296689e7601a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:36003 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbYFDLR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 07:17:27 -0400
Received: by ti-out-0910.google.com with SMTP id b6so14957tic.23
        for <linux-omap@vger.kernel.org>; Wed, 04 Jun 2008 04:17:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi,

i am trying to compile microwindows for omap5912-osk.

when i "make" i get the following error.

it looks like there is a #define that has to be changed. but i have no
idea how to do it.

[root@localhost src]# make
Compiling engine/image_jpeg.c ...
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:49:21:
jpeglib.h: No such file or directory
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:54: error: parse
error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: In function
`init_source':
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:56: error:
`cinfo' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:56: error: (Each
undeclared identifier is reported only once
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:56: error: for
each function it appears in.)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: At top level:
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:61: error: parse
error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:67: error: parse
error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: In function
`skip_input_data':
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:69: error:
`num_bytes' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:71: error:
`cinfo' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: At top level:
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:76: error: parse
error before "resync_to_restart"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:76: error: parse
error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:77: warning:
return type defaults to `int'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: In function
`resync_to_restart':
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:78: warning:
implicit declaration of function `jpeg_resync_to_restart'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:78: error:
`cinfo' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:78: error:
`desired' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: At top level:
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:82: error: parse
error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c: In function
`GdDecodeJPEG':
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:93: error:
storage size of 'smgr' isn't known
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:94: error:
storage size of 'cinfo' isn't known
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:95: error:
storage size of 'jerr' isn't known
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:119: warning:
implicit declaration of function `jpeg_std_error'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:122: warning:
implicit declaration of function `jpeg_create_decompress'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:137: warning:
implicit declaration of function `jpeg_read_header'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:139: error:
`JCS_GRAYSCALE' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:139: error:
`JCS_RGB' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:159: error:
`j_common_ptr' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:159: error:
`JPOOL_IMAGE' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:160: error:
`JDIMENSION' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:160: error:
parse error before "cinfo"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:182: warning:
implicit declaration of function `jpeg_calc_output_dimensions'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:223: warning:
implicit declaration of function `jpeg_start_decompress'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:227: error:
`JSAMPROW' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:227: error:
parse error before "rowptr"
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:228: error:
`rowptr' undeclared (first use in this function)
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:230: warning:
implicit declaration of function `jpeg_read_scanlines'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:236: warning:
implicit declaration of function `jpeg_finish_decompress'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:239: warning:
implicit declaration of function `jpeg_destroy_decompress'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:93: warning:
unused variable `smgr'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:94: warning:
unused variable `cinfo'
/root/omap5912/nanox/microwin/src/engine/image_jpeg.c:95: warning:
unused variable `jerr'
make[1]: *** [/root/omap5912/nanox/microwin/src/obj/engine/image_jpeg.o] Error 1
make: *** [subdir-/root/omap5912/nanox/microwin/src/mwin] Error 2
[root@localhost src]#

thank you.
regards,
Shareef
