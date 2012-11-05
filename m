From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 5 Nov 2012 06:44:10 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA63234@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
 <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
 <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
 <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 04, 2012 at 23:07:44, Linus Walleij wrote:
> On Tue, Oct 30, 2012 at 3:12 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> 
> > I completely understood this named modes, I have added named
> > modes like this in am335x-xxx.dts files
> 
> I do not understand how the pinctrl-single dts files work actually,
> so please get Tony to review this part.
> 
> > I think "pinctrl-1" state will be used in driver
> > suspend/resume calls.
> 
> Hopefully, I think you should test the code and monitor the
> system to make sure the right thing happens.

I will test while adding "pinctrl-1" data to .dts files.

> 
> > I have the pinmux/conf settings for default state but fully
> > optimized pinmux/conf values in idle & suspend states are not
> > available yet.
> 
> You have defined a "sleep" state which is what should be used
> for suspend? Or do you mean that you do have a state but
> you're just not defining it to the most optimal setting yet?

Yes, sleep state is used for suspend. Regarding to this suspend
state fully optimized pinmux/conf values are not available.

Thanks
AnilKumar
