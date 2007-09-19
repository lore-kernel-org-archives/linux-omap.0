From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: HS USB support for 2.6.14 V4 kernel
Date: Wed, 19 Sep 2007 20:56:44 +0530
Message-ID: <c04186510709190826x7d5d5c0fwf934f52b30c0136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello all,

I am using 2.6.14 V4 kernel on 2430SDP board, trying to bring up the High
Speed USB (Inventra core) on ISP1504 OTG.
I could able to configure and detect the SDP board as ethernet Gadget
device, but I could not use ISP1504 as USB-Host.

I am using the following DIP switch settings:

S6 - 2 ------> ON
S6 - 6 ------> OFF
S6 - 7 ------> OFF

I am getting "musb_hdrc.0" interrupts when I plug an USB Hub, but  no
interrupts are generated when
I insert a device like mouse or memory stick.

Could anyone able to use ISP1504 as USB host ? is there any other kernel
version
where the High Speed USB on ISP1504 OTG is working ?

-- 
Thanks in Advance,
Sandeep
