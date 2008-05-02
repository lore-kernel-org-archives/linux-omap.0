From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Booting OMAP5912 with 2.6.8 kernel
Date: Fri, 2 May 2008 09:16:30 -0500
Message-ID: <5573C19A4BBDB441BED2A44157E9705303C3FE93@dlee12.ent.ti.com>
References: <5573C19A4BBDB441BED2A44157E9705303C3FE65@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55773 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758204AbYEBOQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 10:16:57 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5573C19A4BBDB441BED2A44157E9705303C3FE65@dlee12.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rajagopal.venkat@gmail.com
Cc: linux-omap@vger.kernel.org

> My intension here is to use filesystem flashed onto the flash memory
at
> 0x1000000 location. When tried booting with Montavista kernel which
comes
> with CD, it works fine. But fails when tried booting with custom
kernel
> compiled using 2.6.8-rc3_080804.tar.bz2 package from TI site.
> True that it could not find root file system which is placed at
0x1000000
> of flash. But what could be the root value
> to make it work?  does manual partition of the FLASH memory is
required ?


If you are trying to use the 2.6.8 kernel with the default file-system
that comes with the OSK, I don't believe this will work. The montavista
kernel that comes with the OSK is a 2.4 kernel and not 2.6. Therefore,
you should create a new flash file-system for the 2.6.8 kernel. 

Check out the OSK wiki page: http://elinux.org/OSK

In particular see the "OSK5912 Newbie Guide" that provides details on
how to create a flash file-system. 

http://www.capgo.com/Resources/SoftwareDev/osk-newbie-guide.pdf

Also, please copy the list. You can also search the mailing list on the
following page, as there has been a lot of discussion with regard to the
OSK in the past. 

http://dir.gmane.org/gmane.linux.ports.arm.omap

Cheers
Jon
