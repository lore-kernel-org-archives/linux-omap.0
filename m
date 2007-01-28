From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: definite OMAP1610_IR-related typo
Date: Sun, 28 Jan 2007 08:13:02 +0100
Message-ID: <45BC4CFE.7050602@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-omap-open-source@linux.omap.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Robert P. J. Day wrote at LKML:
 > not sure what to do with this, it's all yours:
 >
 > ========== OMAP1610_IR ==========
 > ./arch/arm/mach-omap1/devices.c:#if 
defined(CONFIG_OMAP1610_IR) ||
 > defined(CONFIG_OMAP161O_IR_MODULE)
 > ========== OMAP161O_IR ==========
 > ./arch/arm/mach-omap1/devices.c:#if 
defined(CONFIG_OMAP1610_IR) ||
 > defined(CONFIG_OMAP161O_IR_MODULE)
 >
 > note first that one of those config vars has an "oh" 
while the other
 > has a *zero*. i'm pretty sure that's bad.
 >
 > in any event, there's no such config variable of *either* 
spelling
 > in any Kconfig file, but there *is* a more all-encompassing
 > CONFIG_OMAP16XX confguration setting.

This is fixed in recent OMAP git tree and OMAP patches we 
prepared for upstream. Can you try OMAP patches 4113, 4114, 
4115 and 4116 to be found in RMKs patch system [1]? Or, even 
better, use current OMAP git [2]?

Regards

Dirk

P.S. #1: Would be nice to CC OMAP list [3] next time as well.

P.S. #2: Sorry if mail references are wrong, I'm currently 
not subscribed to LKML.

[1] 
http://www.arm.linux.org.uk/developer/patches/section.php?section=0

[2] 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=summary

[3] 
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
