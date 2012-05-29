From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Tue, 29 May 2012 14:46:55 -0500
Message-ID: <CAOMWX4ctJcfGNxXK4hT+QH-m7zUfP1N3H56oVDVzPFmhVTFOMw@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
 <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
 <CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 17, 2012 at 3:52 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
[...]
>>> - Rather than hooking into omap4_enter_lowpower(), should use
>>> =A0the cluster PM enter/exit notifier chain.
>>>
>> This is again specific to device OFF only and not related to CPU
>> cluster state as such. So I don't think notifiers should be used here.
>>
>> O.w even when we attempt just MPU OSWR C-state, all these functions will
>> get called in notifier chain.
>>
> Just a thought, we can have a separate notifier chain for device OFF. It =
can
> allow use to get rid of 'enable_off_mode" kind of flags and can be
> used by many drivers too.

Like the overall idea, but one minor dumb concern might be sequencing
of notifiers
 - OFF entry and restore needs things to be executed in a specific sequence.
How do we plan to ensure the sequence is maintained in a notifier call
chain? one
possible option might be a "priority" based scheme?

Regards,
Nishanth Menon
