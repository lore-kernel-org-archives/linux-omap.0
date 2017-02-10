From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Fri, 10 Feb 2017 08:43:49 +0530
Message-ID: <20170210031349.GG14503@vireshk-i7>
References: <20170203172929.23940-3-d-gerlach@ti.com>
 <20170209153549.8354-1-d-gerlach@ti.com>
 <CAJZ5v0hT4peuRQUrLHC32GmVSoa6Npv2qutNo2WEhne72hHi6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hT4peuRQUrLHC32GmVSoa6Npv2qutNo2WEhne72hHi6A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 09-02-17, 23:03, Rafael J. Wysocki wrote:
> In particular, Viresh, if you ACK something, please make sure that it
> doesn't conflict with your own patches.

I hope you are talking about the patch 3/4 for which Arnd also sent a
fix.  I acked it back on 18th of January and Dave has been carrying my
Ack since then. When he posted again, I didn't went into reviewing it
again as I saw my Ack being there.

Yes, he ended up using an API which just got updated after 18th of Jan
and yes both me and Dave missed that. But I feel it is difficult to
take care of scenarios like this. Perhaps he should have made sure
that he base it of pm/linux-next and nothing would have gone wrong.

-- 
viresh
