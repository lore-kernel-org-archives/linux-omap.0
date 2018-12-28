From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
Date: Fri, 28 Dec 2018 12:04:13 -0800
Message-ID: <20181228200413.GZ6707@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
 <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
 <20181223163040.GO6707@atomide.com>
 <CAHCN7xJKyjXb6br-f+_q_dQxkqWHFxFfA+X_yYG4eh8w7RW8SQ@mail.gmail.com>
 <20181227165812.GS6707@atomide.com>
 <CAHCN7xKyvXPMSaRQ_qP4u_bX7uh=52OUCtfO2XW974=rNnRcXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xKyvXPMSaRQ_qP4u_bX7uh=52OUCtfO2XW974=rNnRcXw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [181227 17:05]:
> Thanks for the clarifcation.  Is this additional IRQ and wakeup stuff
> something I should add to the Torpedo and SOM-LV boards?  I think
> right now, I'm just triggering on the GPIO rising edge.

Yes as those boards work with off-mode during idle. Unless
you configure the wlcore wakeirq, pinging a device will not
wake up the SoC. And ssh latency will be bad.

Regards,

Tony
