From: Arnold <abo_gwapo@yahoo.com>
Subject: RE: MCSI & MCBSP howto configure as gpio
Date: Thu, 10 Aug 2006 03:04:07 -0700 (PDT)
Message-ID: <20060810100407.29417.qmail@web55805.mail.re3.yahoo.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBEEC6821@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBEEC6821@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Khasim, Syed" <x0khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khasim, All,

> If you have access to TRM of OMAP you are working
> on, then see the
> relevant chapter for pin mux, it should tell you the
> mode to configure
> (inorder to configure a McBSP1 pin as GPIO).
Does TRM  stands for Technical Reference Manual? I
read the manual and checked the mux.c, but I could'nt
trace/find the parameters passed to MUX_CFG. I used
mcbsp3_clkx as an example:
MUX_CFG("MCBSP3_CLKX",3,1,1,29,0,NA,0,1)
I can trace until the mux reg, but I cant find the
next parameters in the TRM. The parameters that I cant
find/trace in the manual are mode offset,mux mode,pull
reg ... etc.  Does anyone knows where I can find a
spec on this mux? I am trying to add MCSI1 so that I
can configure it as gpio. I hope to hear from you
guys. Thank you.

Regards,
OJ 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
