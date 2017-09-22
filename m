From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Add hwmod data for IPU & DSP processors/MMUs
Date: Fri, 22 Sep 2017 10:51:10 -0700
Message-ID: <20170922175110.GC4394@atomide.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <d4715d1e-8113-050b-9a0f-77f4a4486081@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d4715d1e-8113-050b-9a0f-77f4a4486081@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [170922 10:19]:
> Ping on this series. Tero's clkctrl series changes are orthogonal to
> these changes.

With patch 5/8 you said earlier "It will still be a shared set
between the MMU and remoteproc drivers, but let me look into
how these get integrated." So was there any conclusion there?

Also, what's the deal with these omap4 changes that I commented
on in 5/8?

Regards,

Tony
