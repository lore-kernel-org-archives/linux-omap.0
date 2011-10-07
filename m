From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 6/6] OMAP4: Clock: Correct the name of SLIMBUS interface
	clocks
Date: Fri, 7 Oct 2011 10:23:09 +0200
Message-ID: <4E8EB6ED.9020605@ti.com>
References: <1316195330-15099-1-git-send-email-jon-hunter@ti.com>
	<alpine.DEB.2.00.1110061941100.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1110061941100.4611@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Paul & Jon,

On 10/7/2011 3:42 AM, Paul Walmsley wrote:
> + Beno=EEt
>
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> Currently the interface clocks for the two SLIMBUS peripherals are
>> named slimbus1_fck and slimbus2_fck. Rename these clocks to be
>> slimbus1_ick and slimbus2_ick so it is clear that these are
>> interface clocks and not functional clocks.
>>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>
> This one, I don't quite understand.  We should probably be removing these
> MODULEMODE-only clocks from the OMAP4 tree, and using their parent clock
> as the main_clk.  That would be a good cleanup for 3.3...

Yes, but in order to remove that from the clock data we must ensure that =

the hwmod entry is there.
I kept a lot of legacy MODULEMODE clocks just because of missing hwmod / =

runtime_pm adaptation on some drivers.

In the case of slimbus, there is no main_clk but a bunch of optional =

clocks. It looks similar to the DSS case. So we should not use the =

parent clock as a main_clk.

We should probably promote one of the opt_clk as the main_clk. The =

slimbus_clk seems to be the good candidate for both instances.

static struct omap_hwmod_opt_clk slimbus1_opt_clks[] =3D {
        { .role =3D "fclk_1", .clk =3D "slimbus1_fclk_1" },
        { .role =3D "fclk_0", .clk =3D "slimbus1_fclk_0" },
        { .role =3D "fclk_2", .clk =3D "slimbus1_fclk_2" },
        { .role =3D "slimbus_clk", .clk =3D "slimbus1_slimbus_clk" },
};

static struct omap_hwmod_opt_clk slimbus2_opt_clks[] =3D {
        { .role =3D "fclk_1", .clk =3D "slimbus2_fclk_1" },
        { .role =3D "fclk_0", .clk =3D "slimbus2_fclk_0" },
        { .role =3D "slimbus_clk", .clk =3D "slimbus2_slimbus_clk" },
};

Jon,
Do you know if that one is indeed mandatory to use the slimbus IP?

Thanks,
Benoit
