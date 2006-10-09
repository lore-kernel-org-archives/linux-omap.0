From: Zgembo Adislic <adislic_zgembo@yahoo.com>
Subject: omap IrDA problem
Date: Mon, 9 Oct 2006 01:21:41 -0700 (PDT)
Message-ID: <20061009082141.64024.qmail@web30611.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



Hello all,
     I am working on setting up IrDA communication between omap5910(1510) and my PC. I am
using 2.6.8.1 kernel. I got this link from a Samuel Ortiz(many thanx)  on witch I found
drivers which should suppose to work on my board.
    
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=70ca65ca7eb8b730de0b674efbc26d72748a3b65
     But I am still unable to make IrDA work on my board. I compiled my kernel with this
driver and I ported it to my board. 
     When I boot up my board and type ifconfig irda0 up in terminal window I got this
message. 
     Irda0  Link encap: UNSPEC Hwaddr ---- and so on. 
     I tried to compare the result of this command with result that I get when I do the same
on my laptop, which is running on Linux and I get something like this.
     Irda0 Link encap: IrLAP --- and so on.
     So I am little confused about this problem. I trayed to measure signals on my IrDA port
with oscilloscope, and I can see that I am receiving some kind of signals but I can not see
anything on console. 
     And one more thing, when I run &#65533;echo xxx > /dev/ttyS2&#65533; I got constant light on TX port
which I can not turn off until I reboot the device. 
     I am pretty much run off any ideas, so if anyone have any idea please respond J 
     Thanx,
     Zgembo

 
 		
---------------------------------
Do you Yahoo!?
 Get on board. You're invited to try the new Yahoo! Mail.
