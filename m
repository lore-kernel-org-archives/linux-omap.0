From: Arnold <abo_gwapo@yahoo.com>
Subject: Re: mcbsp
Date: Tue, 8 Aug 2006 19:19:28 -0700 (PDT)
Message-ID: <20060809021928.76417.qmail@web55808.mail.re3.yahoo.com>
References: <ce55079f0608080619h8c565c4rf22bbb26a5913c4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ce55079f0608080619h8c565c4rf22bbb26a5913c4f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vladimir <vovan888@gmail.com>, "Khasim, Syed" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Guys,

>This is possible by changing
> the mux settings of
> > McBSP lines to GPIO mode and use the GPIO APIs to
> read and write to
> > them.

Can I use omap_cfg_reg to change the mux settings? If
so, I'm confuse if what will I pass to this function.
I looked at the mux.h and I cant find the mcbsp1.***.
I could see mcbsp2 there but not 1.  Thank you guys.

Regards,
OJ

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
