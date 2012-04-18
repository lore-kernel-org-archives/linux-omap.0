From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/9] ARM: OMAP3+: voltage: export functions to
 plat/voltage.h
Date: Wed, 18 Apr 2012 22:36:05 +0200
Message-ID: <CAORVsuWBHVhHnqBeKQ8hb2p+UsRP84O-Hq=bXYQv2wBJyfELGA@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-2-git-send-email-j-pihet@ti.com>
 <87y5ptkl0u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87y5ptkl0u.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>, KEERTHY J <j-keerthy@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

Adding Keerthy J

On Wed, Apr 18, 2012 at 7:27 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Move some functions from mach-omap2/ dir to the plat/ dir.
>> The SmartReflex class driver is a user of the basic voltage domains
>> functions (enable, disable, reset).
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Rather than expose the VP functions directly, how about adding a new API
> at the voltdm layer to start/stop AVS. =A0Maybe something like:
>
> =A0voltdm_avs_start(struct voltagedomain *voltdm)
> =A0voltdm_avs_stop(struct voltagedomain *voltdm)
>
> These will internally just call VP enable/disable for now, but we may
> have more to add to these in the future to support other SR classes.
Agree.
That would be a first step in the definition of the API between SR and
VP. Implementing other SR classes might require more than that, this
is still under investigation for now.

>
> Kevin
>

Thanks for reviewing,
Jean
