From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 20:56:27 +0300
Message-ID: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

I was reading OMAP3 TRM and I couldn't find the offset of PRCM
register at memory maps. In OMAP2 I can clearly see PRCM there... also
in omap34xx.h there's no such definition, even though we need it in
order to build support for USB OTG.

How should I handle it ?? probably we're gonna need to change
something in arch/arch/mach-omap2/mmu.c ??

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
