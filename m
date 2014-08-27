From: "Martin Hinteregger" <martin.hinti@gmx.at>
Subject: [RFI] OMAP4 ISS: l3_interrupt_handler Errors due to wrong
 initialized iss_fck?
Date: Wed, 27 Aug 2014 17:26:56 +0200
Message-ID: <trinity-94241b67-ba3b-473f-bc89-84fecd218ba9-1409153216294@3capp-gmx-bs58>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

I am trying to get both CSI2 interfaces up and running through the ISS=20
on the v3.16 kernel for the TI OMAP4 Blaze platform (omap4430 ES 2.3=20
revision).

Trough a omap_device_build() call (using the "iss" omap_hwmod) I call t=
he=20
iss_probe function. It devm_clk_get's both the iss_ctrlclk and the iss_=
fck.=20
Since I am building the kernel with the omap4-sdp-es23plus device tree=20
appended, I figured I need to define the iss_fck in the omap44xx-clocks=
=2Edtsi=20
file, right after the iss_ctrlclk, as following:

iss_fck: iss_fck {
	#clock-cells =3D <0>;
	compatible =3D "ti,gate-clock";
	clocks =3D <&ducati_clk_mux_ck>;
	ti,bit-shift =3D <1>;
	reg =3D <0x1020>;
};

=46or that, I used the information in [1], the TI clock tree tool and t=
he=20
Linux documentation.

Now the omap4iss_get() call throws L3 Standard Errors, right after the =
first=20
time the interrupts, set in iss_enable_interrupts, occur. I am pretty s=
ure the=20
cause for that is a wrong initialization of the iss_fck (since I haven'=
t=20
changed much more), even though the kernel runs through and the=20
"cat clk_summary =C2=A6 grep iss" command in /sys/kernel/debug/clk/ wri=
tes:
iss_ctrlclk         0            1    96000000          0
iss_fck             0            1   400000000          0

Could there be an error in the device tree entry stated above? Or might=
 I be=20
missing something else? Has anyone ever enabled iss_fck through device =
tree?

BTW I've also added iss_fck as an opt_clk in omap_hwmod_44xx_data and a=
dded=20
the clock to the ti_dt_clk struct.

Thanks,
Martin

[1] http://www.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vAJ.zip
