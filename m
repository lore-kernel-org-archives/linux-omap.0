From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/4] clk: dt: add support for default rate/parent
Date: Fri, 21 Mar 2014 10:12:17 +0200
Message-ID: <20140321081217.GD26674@tbergstrom-lnx.Nvidia.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <53172239.3030705@ti.com> <20140320212308.21989.36094@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140320212308.21989.36094@quantum>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 20, 2014 at 10:23:08PM +0100, Mike Turquette wrote:
> Quoting Tero Kristo (2014-03-05 05:10:17)
> > Ping.
> > 
> > Mike, any feedback on this?
> 
> Hi Tero,
> 
> Have you seen Sylwester's approach[1]? I prefer it since it is more
> device-oriented and less "centralized". The clock consumer enumerates
> the default parent or rate of a consumed clock. This can be made to work

That assumes driver writers are aware of the clock tree topology. IME that's
seldomly the case.

Cheers,

Peter.
