From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] power_supply: Introduce generic psy charging driver
Date: Fri, 7 Mar 2014 11:03:02 +0800
Message-ID: <CACRpkdbuCC=-aYmyeaGW0GfkhRU8SEc=1+2f6k3tA7TygiZRJA@mail.gmail.com>
References: <1392875640-29230-1-git-send-email-jenny.tc@intel.com>
	<1392875640-29230-3-git-send-email-jenny.tc@intel.com>
	<CACRpkdaU44iinj2iDNdYm62J+4jQbg+XJ=Zq4GmJryPeu7GfTQ@mail.gmail.com>
	<20140228042753.GC27921@jenny-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140228042753.GC27921@jenny-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny Tc <jenny.tc@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, =?windows-1251?B?yOLg6evuIMTo7Ojy8O7i?= <freemangordon@abv.bg>, Linux-
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 28, 2014 at 12:27 PM, Jenny Tc <jenny.tc@intel.com> wrote:
> On Thu, Feb 27, 2014 at 09:08:01PM +0100, Linus Walleij wrote:
>> On Thu, Feb 20, 2014 at 6:53 AM, Jenny TC <jenny.tc@intel.com> wrote:
>>
>> > +++ b/include/linux/power/power_supply_charger.h
>>
>> > +#define MAX_CUR_VOLT_SAMPLES 3
>> > +#define DEF_CUR_VOLT_SAMPLE_JIFF (30*HZ)
>>
>> Why are things defined in Jiffies like this insead of seconds, milliseconds
>> etc? This will vary with the current operating frequency of the system,
>> why should physical measurements do that?
>
> Is it fine if I use msecs_to_jiffies(30000)?

Keep the
#define DEF_CUR_VOLT_SAMPLE_PERIOD 30000

Then use msecs_to_jiffies(DEF_CUR_VOLT_SAMPLE_PERIOD)
in the call site.

>> > +enum psy_charger_cable_event {
>> > +       PSY_CHARGER_CABLE_EVENT_DISCONNECT = 0,
>> > +       PSY_CHARGER_CABLE_EVENT_CONNECT,
>> > +       PSY_CHARGER_CABLE_EVENT_UPDATE,
>> > +       PSY_CHARGER_CABLE_EVENT_RESUME,
>> > +       PSY_CHARGER_CABLE_EVENT_SUSPEND,
>> > +};
>> > +
>> > +enum psy_charger_cable_type {
>> > +       PSY_CHARGER_CABLE_TYPE_NONE = 0,
>> > +       PSY_CHARGER_CABLE_TYPE_USB_SDP = 1 << 0,
>> > +       PSY_CHARGER_CABLE_TYPE_USB_DCP = 1 << 1,
>> > +       PSY_CHARGER_CABLE_TYPE_USB_CDP = 1 << 2,
>> > +       PSY_CHARGER_CABLE_TYPE_USB_ACA = 1 << 3,
>> > +       PSY_CHARGER_CABLE_TYPE_AC = 1 << 4,
>> > +       PSY_CHARGER_CABLE_TYPE_ACA_DOCK = 1 << 5,
>> > +       PSY_CHARGER_CABLE_TYPE_ACA_A = 1 << 6,
>> > +       PSY_CHARGER_CABLE_TYPE_ACA_B = 1 << 7,
>> > +       PSY_CHARGER_CABLE_TYPE_ACA_C = 1 << 8,
>> > +       PSY_CHARGER_CABLE_TYPE_SE1 = 1 << 9,
>> > +       PSY_CHARGER_CABLE_TYPE_MHL = 1 << 10,
>> > +       PSY_CHARGER_CABLE_TYPE_B_DEVICE = 1 << 11,
>> > +};
>>
>> Why is this even an enum? It is clearly bitfields. I would just:
>>
>> #include <linux/bitops.h>
>>
>> #define PSY_CHARGER_CABLE_TYPE_NONE 0x0
>> #define PSY_CHARGER_CABLE_TYPE_USB_SDP BIT(0)
>> #define PSY_CHARGER_CABLE_TYPE_USB_DCP BIT(1)
>> (etc)
>
> This is to ensure type checks when the cable types are handled, #defines will
> not help in type checks.

Type checks with static code check tools? But misrepresenting
a bitfield as an enum just to satisfy a static code checker is not
OK IMO.

Yours,
Linus Walleij
