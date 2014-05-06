From: Joachim  Eastwood <manabian@gmail.com>
Subject: Re: [PATCH v2 0/4] Support for Variscite OM44 modules and boards
Date: Tue, 6 May 2014 20:02:52 +0200
Message-ID: <CAGhQ9VystybERsiPUX4ESNBcKPKBN44GvuPUtTM+jpywUqON3A@mail.gmail.com>
References: <1398971269-20515-1-git-send-email-manabian@gmail.com>
 <20140506001530.GL25949@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140506001530.GL25949@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

1On 6 May 2014 02:15, Tony Lindgren <tony@atomide.com> wrote:
> * Joachim Eastwood <manabian@gmail.com> [140501 12:08]:
>> Hello,
>>
>> This patch set adds support for Variscite OM44 series of system on modules and boards.
>>
>> There weren't many comments on v1 of this patch set so I hope this can make it into 3.16.
>> Changes since v2:
>>  * Use OMAP IOPAD macros
>>
>> Patch 1: Add support for the SoM itself and the reference carrier board. Together these make the VAR-STK-OM44 dev kit.
>> Patch 2: Add support for VAR-DVK-OM44 which is just the STK with a LCD display.
>> Patch 3: Nodes for WLAN/BT support.
>> Patch 4: Add quirks so that WLAN can be used. Still waiting for proper DT bindings.
>>
>> Since this patch set now uses the IOPAD macros a fix from Tony is need.
>> See: https://patchwork.kernel.org/patch/4025421/
>
> Just noted that the macro won't work while was about to
> apply these, sorry. So we're back to either using the
> existing OMAP4_WKUP_IOPAD or raw offset from the padconf
> area unless you have some great macro ideas.

I see. I'll take another look at the macro's and see what I can come up with.

>> Note that patch 1 relies upon a patch from Tomi Valkeinen add hpd-gpio (hotplug detect) to the "hdmi-connector".
>> See: http://marc.info/?l=linux-omap&m=139771947508021&w=2
>>
>> Patch 2 also relies upon a patch from Tomi that adds DT support to panel-dpi.
>> See: http://marc.info/?l=devicetree&m=139030201815380&w=2
>
> Maybe also leave out the DSS changes until Tomi has confirmed
> those?

I can split the patch set and put a patch with the DSS DT nodes at the
end. Maybe this last patch can go through Tomi if he has a DSS DT
branch. I don't want to drop it entirely from the patch set because
some other people has expressed interest in testing it with full
display and hdmi support.

I am traveling right now and don't have access to my development
machine. So I won't be able to rework the patch set until early next
week.

regards
Joachim Eastwood
