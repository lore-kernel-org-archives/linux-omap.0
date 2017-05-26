From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: am335x-sl50: Fix card detect pin for mmc1
Date: Fri, 26 May 2017 08:30:46 -0700
Message-ID: <20170526153045.GA3717@atomide.com>
References: <20170522090153.5596-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170522090153.5596-1-enric.balletbo@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Enric Balletbo i Serra <enric.balletbo@collabora.com> [170522 02:05]:
> The second version of the hardware moved the card detect pin from gpio0_6
> to gpio1_9, as we won't support the first hardware version fix the pinmux
> configuration of this pin.

OK so proto vs production version misconfiguration, applying both into
omap-for-v4.12/fixes-v2 thanks. Note that you're not supposed to send
any email to the stable list unless requesting a backport of something.
The idea is to add the stable tag when committing, and nowadays it seems
having a proper "Fixes" tag seems to do the job automatically.

Regards,

Tony
