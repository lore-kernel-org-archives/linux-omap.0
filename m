From: Komal Shah <komal_shah802003@yahoo.com>
Subject: OMAP2 irq.c IVA_INTC base
Date: Mon, 21 Aug 2006 05:12:06 -0700 (PDT)
Message-ID: <20060821121206.36058.qmail@web37911.mail.mud.yahoo.com>
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
To: linux-omap-open-source@linux.omap.com, paul.mundt@nokia.com, r-woodruff2@ti.com
List-Id: linux-omap@vger.kernel.org

Paul/Richard,

I want one clarification about IVA_INTC base address in irq.c. I think
that 0x40000000 address is only accessible in the IVA-MPU domain _not_
in L3 domain, then how we are going to initialize it from ARM11 side? I
believe that it should be initialized by framework running on IVA1.0.

We have only access to IVA registers of various blocks and
co-processors which are mapped in the L3 domain.


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
