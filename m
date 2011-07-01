From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 10/12] omap: mcbsp: Move sidetone clock management to
	mach-omap2/mcbsp.c
Date: Fri, 1 Jul 2011 11:26:36 +0200
Message-ID: <4E0D92CC.5030006@ti.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-11-git-send-email-jhnikula@gmail.com>
	<alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

On 7/1/2011 11:23 AM, Paul Walmsley wrote:
> + Beno=EEt
>
> Hello Jarkko
>
> On Fri, 1 Jul 2011, Jarkko Nikula wrote:
>
>> Active sidetone requires that McBSP interface clock doesn't idle and the=
re
>> is no mechanism in hwmod to turn autoidling on/off in runtime. McBSP2 an=
d 3
>> in OMAP34xx share their interface clock with McBSP sidetone module and
>> that interface clock must be active when the sidetone is operating.
>>
>> Sidetone has its own autoidle bit which should keep the interface clock
>> active but it is broken. Putting the McBSP core to no-idle mode when the
>> sidetone is active is no good either since it results to higher power
>> consumption when using the threshold based DMA transfers.
>
> In the hwmod code/data, we've got the OCPIF_SWSUP_IDLE flag that can be
> set on a struct omap_hwmod_ocp_if.  I think this is probably what's needed
> here.  The only problem is that we haven't linked that to the clock code
> to deny idle on the interface clock yet (see omap_hwmod.c:_setup()).
> Adding that code in, plus adding that OCPIF_SWSUP_IDLE flag to the
> McBSP2/3 data, seems like the right approach here.
>
> I guess we also will need some basic usecounting for denying idle in the
> clock code.
>
> Otherwise these direct register manipulations of clock registers, outside
> the clock code, could turn into a mess :-(

AFAIR Kishon did submit some patches to expose this feature to the =

driver through omap_device API. The point is that other broken IP like =

SDMA of USB will require such feature.

Didn't we pull them?

Benoit
