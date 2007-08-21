From: Geoffrey Tam <geoffrey@evertz.com>
Subject: RE: Cannot stall an endpoint 0 control transfer from a data stage
	cal lback function
Date: Tue, 21 Aug 2007 16:10:38 -0400
Message-ID: <0474A5584072DA1197F50007E90E6B1141D5E1@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain
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
To: "'linux-omap-open-source@linux.omap.com'" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Sorry for the long delay.

I just tried out the latest code on the git tree, and it does not work for
me. It does not allow me to stall an endpoint.

-----Original Message-----
From: Kevin Hilman [mailto:khilman@mvista.com]
Sent: Friday, May 18, 2007 2:57 PM
To: Geoffrey Tam
Cc: Tony Lindgren
Subject: RE: Cannot stall an endpoint 0 control transfer from a data
stage cal lback function


On Thu, 2007-05-17 at 12:35 -0400, Geoffrey Tam wrote:

> I am not sure why the mass storage gadget fails to enumerate with my
fixes.
> Unfortunately, my Davinci eval board does not like Linux 2.6.20 - it hangs
> shortly after it is loaded. So, I cannot look into this.
> 
> I will try again when I get the chance.

Geoffrey,

Can you try again with the updated DaVinci git tree.  I just merged the
USB support from the OMAP tree into the DaVinci tree.  

What exactly does your EVM board do when booting.  Can you send me a
console log?

Kevin
