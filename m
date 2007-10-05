From: radha k <radha_kodirekka@yahoo.com>
Subject: USB camera-OSK5912
Date: Fri, 5 Oct 2007 02:15:19 -0700 (PDT)
Message-ID: <507680.62585.qm@web60925.mail.yahoo.com>
References: <470556AB.6030201@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <470556AB.6030201@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi

I hav connected USB Logitech quick cam camera to
OSK5912.I AM USING LINU 2.6.22 KERNEL
I used gspca driver for my camera after amking some
changes to that one.
When it is booting it got detected.and it showing it
is GSPCA Camera(SPCA561A).
I am unable to capture video using that camera.
I hav used one procedure as given in a web site that
is making OSK5912 platfrom as s server using SERVFOX
and USing SPCAVIEW at PC flatfrom.

AT OSK PLATFORM
WHEN I AM DOING THIS  IT IS GIVING ERROR  LIKE THIS 
sh-3.00# ./servfox
 servfox version: 1.1.3 date: 11:12:2005 (C)
mxhaard@magic.fr
wrong spca5xx device
drivers/media/video/gspca/gspca_core.c:
VIDIOCMCAPTURE: invalid format (21)
cmcapture: Invalid
argumentdrivers/media/video/gspca/gspca_core.c:
VIDIOCMCAPTURE: invalid format (21)

cmcapture: Invalid argument
Waiting .... for connection. CTrl_c to stop !!!!
drivers/media/video/gspca/gspca_core.c:
VIDIOCMCAPTURE: invalid format (21)
cmcapture: Invalid argument
Got connection from 10.1.25.211

AT PC SIDE 
./spcaview -w 10.1.25.201:23
 Spcaview version: 1.1.7 date: 06:11:2006 (C)
mxhaard@magic.fr
ERROR Set default port to 7070
using Server 10.1.25.201 Port 7070


AND STRUCKING

I DONT KONW HOW TO RECTIFY THIS

ANY ALTER OTHER METHOD IT NOT AVAILABLE FOR CAPTURING
VIDEO AT OSK 

PLEASE HELP IN THIS REGARD

THANKS IN ADVANCE




       
____________________________________________________________________________________
Be a better Heartthrob. Get better relationship answers from someone who knows. Yahoo! Answers - Check it out. 
http://answers.yahoo.com/dir/?link=list&sid=396545433
