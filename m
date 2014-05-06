From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 5/5] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() varients
Date: Tue, 6 May 2014 09:28:01 -0700
Message-ID: <20140506162800.GJ18474@atomide.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
 <1398769513-8736-6-git-send-email-rnayak@ti.com>
 <4792826.emf6IohHd6@wuerfel> <535F8ADF.6090702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <535F8ADF.6090702@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, s-anna@ti.com, Arnd Bergmann <arnd@arndb.de>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [140429 04:22]:
> On Tuesday 29 April 2014 04:48 PM, Arnd Bergmann wrote:
> > On Tuesday 29 April 2014 16:35:13 Rajendra Nayak wrote:
> >> @@ -393,7 +395,12 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>  
> >>  #if defined(CONFIG_SOC_DRA7XX)
> >>  #undef soc_is_dra7xx
> >> +#undef soc_is_dra74x
> >> +#undef soc_is_dra72x
> >>  #define soc_is_dra7xx()        (of_machine_is_compatible("ti,dra7"))
> >> +#define soc_is_dra74x()        (of_machine_is_compatible("ti,dra74"))
> >> +#define soc_is_dra72x()        (of_machine_is_compatible("ti,dra72"))
> >> +
> > 
> > You shouldn't normally have to define these. Why are they needed?
> > 
> > Maybe it's better to wait for a user to show up, and then we can decide
> > whether we actually want to have them this way, or if there is a better
> > solution for the particular use case.
> > 
> > Normally, we'd want to make run-time decisions based on properties
> > of the nodes a driver is working on, not the global machine compatible
> > string.
> 
> Yeah, actually this can be dropped. There is no user for it now.

OK applying all but the last patch into omap-for-v3.16/dt branch,
it seems there's no need to separate out the fixes in this case.

Regards,

Tony
