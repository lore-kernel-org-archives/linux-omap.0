From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Some comments on Linux-OMAP tree by Russell King
Date: Wed, 14 Dec 2005 20:37:00 +0100
Message-ID: <43A0745C.7090005@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Romain Goyet wrote:
 > By the way, Russell also added this :
 >
 >>Hmm, I notice that omap folk are _still_ buggering up the MMC core in
 >>relation to mmc.c.  It'd also be nice of omap folk could conform to
 >>the agreed usage of clk_use/unuse vs clk_enable/disable as documented
 >>in the header file.  The clock framework *relies* on everyone
 >>following the rules.  Frustrated sigh.

Everybody who is interested in this, "Clock framework" thread on 
linux-arm-kernel starting with (still ongoing)

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-December/032851.html

Dirk
