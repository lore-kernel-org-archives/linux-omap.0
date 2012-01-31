From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/21] OMAP3+: PM: SR/Class3: disable errorgen before
 disable VP
Date: Tue, 31 Jan 2012 11:06:50 +0100
Message-ID: <CAORVsuUNM8bpwyjbG2GcwfiUEf7A54ODC4tfhZNinUhQTE3g5w@mail.gmail.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-8-git-send-email-j-pihet@ti.com>
 <4F213860.9050600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F213860.9050600@ru.mvista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, balbi@ti.com, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Sergei,

On Thu, Jan 26, 2012 at 12:26 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
>
> On 25-01-2012 19:16, Jean Pihet wrote:
...

>> Change-Id: Id0145adacfa63d7652a29859ad6c95cc2ac61cc8
> =A0 Please remove this line.
Done!

...

>> +int sr_disable_errgen(struct voltagedomain *voltdm)
>> +{
>> + =A0 =A0 =A0 u32 errconfig_offs, vpboundint_en;
>> + =A0 =A0 =A0 u32 vpboundint_st;
>> + =A0 =A0 =A0 struct omap_sr *sr =3D _sr_lookup(voltdm);
>> +
>> + =A0 =A0 =A0 if (IS_ERR(sr)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: omap_sr struct for sr_%s n=
ot found\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
>
> =A0 Not PTR_ERR(sr)?
_sr_lookup returns a return code using ERR_PTR so the return value
should be checked for errors using IS_ERR. Please note that _sr_lookup
checks for NULL parameter internally.

BTW in the next revision of patches (just submitted) there is an
additional patch [19/19] that fixes a few problems related to the use
of err.h macros.

>
> WBR, Sergei

Regards,
Jean
