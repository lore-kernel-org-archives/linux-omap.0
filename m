From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
Date: Fri, 18 Sep 2015 13:39:17 -0500
Message-ID: <CAOCHtYisPQ2g0GCD4NF7m14TchfaZ+k3UedPoaA0Rjtpo9ug+g@mail.gmail.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CAOCHtYh3pDg6_mdX71G=L5Vz-mOmBnerwR5pjumq5jYQ-tN5Pw@mail.gmail.com>
 <20150918165109.GB8020@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150918165109.GB8020@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 18, 2015 at 11:51 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Robert Nelson <robertcnelson@gmail.com> [150918 09:45]:
>> On Fri, Sep 18, 2015 at 11:29 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > Commit 99f84cae43df ("ARM: dts: add wl12xx/wl18xx bindings") added
>> > device tree bindings for the TI WLAN SDIO on many omap variants.
>> >
>> > I recall wondering how come omap5-uevm did not have the WLAN
>> > added and this issue has been bugging me for a while now, and
>> > I finally tracked it down to a bad pinmux regression, and a missing
>> > deferred probe handling for the 32k clock from palmas that's
>> > requested by twl6040.
>> >
>> > Basically 392adaf796b9 ("ARM: dts: omap5-evm: Add mcspi data")
>> > added pin muxing for mcspi4 that conflicts with the onboard
>> > WLAN. While the omap5-uevm docs say the WLAN is not populated,
>> > this was probably only the case for initial prototypes. Both
>> > omap5-uevm boards I have have WLAN populated.
>>
>> Production boards from svtronics don't populate the wlan..
>>
>> http://www.svtronics.com/EVM/OMAP5432/5432
>>
>> quote: "WiFi not available on this model"

Okay, got an email back from svtronics, there was a special omap5_uevm
+ wlan order option for production units.

>>
>> They have an option to order a version with a "COM8Q" connector to add wlan...
>
> Oh OK interesting.
>
>> http://www.svtronics.com/EVM/OMAP5432/5432C
>>
>> http://www.svtronics.com/EVM/OMAP5432/COM8Q
>>
>> I'm not sure who to bug from that era, but the wlan populated devices
>> might have been prototype only.
>
> Hmm OK. Well as it's a SDIO card, it seems safe to add for now.
> We may want to have a minimal separate dts file if the wiring is
> different with the COM8Q card.

Well we can take care of that as an device tree overlay. ;)

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
