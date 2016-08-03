From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Extcon build failure in next
Date: Wed, 3 Aug 2016 17:47:07 +0200
Message-ID: <CAMuHMdW-3oLvirOEiFhXU=0JXt9K4ki52C16aX+8HB_9gPSxCQ@mail.gmail.com>
References: <20160630053705.GM28140@atomide.com>
 <20160630054112.GN28140@atomide.com> <3746939.q8kt0ym6m3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3746939.q8kt0ym6m3@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 30, 2016 at 1:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, June 29, 2016 10:41:13 PM CEST Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [160629 22:41]:
>> Also I'm seeing:
>>
>> drivers/extcon/extcon.c: In function 'extcon_register_notifier':
>> drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    if (idx >= 0) {
>>          ^
>
> I don't see this one. Which compiler version do you use?

Also seen with m68k-linux-gnu-gcc-4.1 in current mainline (fix claimed
to be applied).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
