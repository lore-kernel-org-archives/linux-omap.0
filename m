From: Rick Bronson <rick@efn.org>
Subject: Mistral AM37x (with AM3715) devel board networking broken
Date: Sat, 06 Nov 2010 08:20:55 -0700
Message-ID: <E1PEkZb-0003Te-AB@amazonia.comcast.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:58081 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481Ab0KFPxf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 11:53:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: srinath@mistralsolutions.com

Hi,

  Should I be able to use the latest omap-linux-2.6 on this board?  I
tried:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
cd linux-omap-2.6; make omap2plus_defconfig ARCH=arm; make

  I get some warnings when it boots but it fails to setup the
networking (smsc911x) correctly.  The boot log is here
http://www.efn.org/~rick/pub/boot1.log

  Just wondered if anyone has any ideas?

  Thanks much for any help.

  Rick
                                                                   _
                                                                  | |
                                                                  / /__
.----------------------------------------------------------._____/ (___)
| Rick Bronson    rick at efn dot org    Tel 541-485-7264  |       (___)
| Amazonia Computing http://www.efn.org/~rick      __ o    |_____  (___)
| 5050 Donald Street       Embedded Linux         _`\<,    |     \_(___)
| Eugene, OR  97405     Software Engineering   __( )/( )__ |
`----------------------------------------------------------'
