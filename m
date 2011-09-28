From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v2 2/6] OMAP4: Clock: round_rate and recalc functions for
	DPLL_ABE
Date: Wed, 28 Sep 2011 15:19:00 -0700
Message-ID: <CAJOA=zPDQ4sqoT7EV7HSa43g_i-q5CT6Q8UBvggG2BBvMrQ_bw@mail.gmail.com>
References: <1316195263-14951-1-git-send-email-jon-hunter@ti.com>
	<alpine.DEB.2.00.1109280056570.4399@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1109280056570.4399@utopia.booyaka.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 11:59 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jon and Mike,
>
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Mike Turquette <mturquette@ti.com>
>>
>> OMAP4 DPLL_ABE can enable a 4X multipler on top of the normal MN multipl=
er
>> and divider. This is achieved by setting CM_CLKMODE_DPLL_ABE.DPLL_REGM4X=
EN
>> bit in CKGEN module of CM1. From the OMAP4 TRM:
>>
>> Fdpll =3D Fref x 2 x (4 x M/(N+1)) in case REGM4XEN bit field is set (on=
ly
>> applicable to DPLL_ABE).
>>
>> Add new round_rate() and recalc() functions for OMAP4, that check the
>> setting of REGM4XEN bit and handle this appropriately. The new functions
>> are a simple wrapper on top of the existing omap2_dpll_round_rate() and
>> omap2_dpll_get_rate() functions to handle the REGM4XEN bit.
>>
>> The REGM4XEN bit is only implemented for the ABE DPLL on OMAP4 and so
>> only dpll_abe_ck uses omap4_dpll_regm4xen_round_rate() and
>> omap4_dpll_regm4xen_recalc() functions.
>>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> Tested-by: Jon Hunter <jon-hunter@ti.com>
>
> Some changes have been made to this patch here, to fix a few minor bugs in
> error paths and to add documentation and Jon's Signed-off-by: (since he's
> in the submittal chain).
>
> Care to review and send any comments? =A0Otherwise, I plan to queue this
> revised version for 3.2.

Your changes to the patch look good.

Regards,
Mike
