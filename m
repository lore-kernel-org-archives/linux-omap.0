From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: board-files: fix i2c_bus for tfp410
Date: Fri, 16 Nov 2012 17:39:44 +0200
Message-ID: <50A65E40.9040208@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
 <20121116135155.GE18527@arwen.pp.htv.fi> <50A64D35.9050109@ti.com>
 <20121116151959.GA19411@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7452282723274585311=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121116151959.GA19411@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, stable@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============7452282723274585311==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F973B8830014FEB74061923"

--------------enig3F973B8830014FEB74061923
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 17:19, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, Nov 16, 2012 at 04:27:01PM +0200, Tomi Valkeinen wrote:
>> On 2012-11-16 15:51, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Fri, Nov 16, 2012 at 02:22:33PM +0200, Tomi Valkeinen wrote:
>>>> The i2c handling in tfp410 driver, which handles converting parallel=
 RGB
>>>> to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af. The=

>>>
>>> commit summary should be added in () after commit hash. This would lo=
ok
>>> like:
>>>
>>> 'was changed in 958f271 (OMAPDSS: TFP410: pdata rewrite).'
>>
>> Yep.
>>
>>>> patch changed what value the driver considers as invalid/undefined.
>>>> Before the patch 0 was the invalid value, but as 0 is a valid bus
>>>                   ^
>>> 		  missing comma (,) character here.
>>
>> Right.
>>
>>>> number, the patch changed this to -1.
>>>>
>>>> However, the fact was missed that many board files do not define the=
 bus
>>>> number at all, thus it's left to 0. This causes the driver to fail t=
o
>>>> get the i2c bus, exiting from the driver's probe with an error, mean=
ing
>>>> that the DVI output does not work for those boards.
>>>>
>>>> This patch fixes the issue by changing the i2c_bus number field in t=
he
>>>> driver's platform data from u16 to int, and setting the bus number t=
o -1
>>>> in the board files for the boards that did not define the bus. The
>>>> exception is devkit8000, for which the bus is set to 1, which is the=

>>>> correct bus for that board.
>>>>
>>>> The bug exists in v3.5+ kernels.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> Reported-by: Thomas Weber <thomas@tomweber.eu>
>>>> [for v3.5, v3.6 stable kernels]
>>>> Cc: stable@vger.kernel.org
>>>
>>> This format is peculiar. Usually people use:
>>>
>>> Cc: stable@vger.kernel.org # v3.5 v3.6
>>
>> Yes, I tried that. But my git send-email (1.7.10.4) rejects that line.=
 I
>> don't know if it's my setup, that particular git version, or what...
>=20
> weird... I never had that problem, since git 1.6.x, I have never seen
> that and I tend to upgrade rather frequently. I'm using 1.8.0 now and
> have sent a few patches to stable recently with no problems.
>=20
>>> To be fair, the whole i2c_bus_num looks like a big hackery introduced=
 by
>>> the way panel drivers are written for OMAP DSS.
>>>
>>> TFP410 is an I2C client, not an OMAPDSS client. After a quick look at=

>>> the driver, there's is no such thing as a DSS bus, so looks like you
>>> should have an I2C driver for TFP410 and the whole DSS stuff should b=
e
>>> just a list of clients, but not a struct bus at all.
>>>
>>> The fact that you have to pass the I2C bus number down to the panel
>>> driver is already a big indication of how wrong this is, IMHO.
>>
>> Without going deeper in the dss device model problems, I would agree
>> with you if this was about i2c panel, but this is not quite like that.=

>>
>> A panel controlled via i2c would be an i2c device. But TFP410 is not
>> controlled via i2c. It's not really controlled at all except via
>> power-down gpio. TFP410 doesn't need the i2c to be functional at all.
>=20
> then why does it need the i2c adapter ? What is this power-down gpio ?
> Should that be hidden under gpiolib instead ?

For the i2c, see below. Power-down GPIO is used to power down and up the
tfp410 chip.

>> The i2c lines do not even touch TFP410 chip, so to be precise, the i2c=

>> lines should not be TFP410's concern. The i2c lines come from the
>> monitor and go to OMAP's i2c pins. But TFP410 driver is a convenient
>> place to manage them.
>=20
> fair enough... but who's actually using those i2c lines ? OMAP is the
> I2C master, who's the slave ? It's something in the monitor, I assume..=
=2E
>=20
> IIUC, this I2C bus goes over the HDMI wire ?

Yes, the i2c goes over HDMI wire. OMAP is the master, monitor is the
slave. You can see some more info from
http://en.wikipedia.org/wiki/Display_Data_Channel under DDC2 section.

It is used to read the EDID
(http://en.wikipedia.org/wiki/Extended_display_identification_data)
information from the monitor, which tells things like supported video
timings etc.

As for why the tfp410 driver handles the i2c... We don't have a better
place. There's no driver for the monitor. Although in the future with
common panel framework perhaps we will.

 Tomi



--------------enig3F973B8830014FEB74061923
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpl5AAAoJEPo9qoy8lh71K/IP/iLBFNvuYLRb1wKEhc2vCBln
JRwYmRx0py8MeSUAczV8npL1Znj4WNbFrhaI2BarHtJvrb16ozbm5AQbLEX+EW0X
cYhGWw3bi7VioIU9PhXfGBc2bvFFXF3nOgEuLdj8m/+KgeMqx7W8E1zL3EodsfLS
AMA4Xz+DH4RhMoc3RdjNC6WnONqIg+iC9M79MtGemDSIwAicrP1OI7oe5F24+p8U
5CNp4LCv0bTTt05wfLap6kA0StPfT+0roLQ46ihrwU9Bpjice7QxOyvNKzEFPF57
wtPokhkusAnKSwlIygKis2sUFXytzmHIHSSPmre/Tm8D0xtxLVLrex4VNOq5Hgp7
sVU6gE+4eH7phYF2Xsv+HeWpvqjob8iQ32+CYdZn7tH3F/dYIEqutgUtPc76DEyr
+TSaJqQqNFLvumSiKcJ1G6rbyPlvWwTYzuGrDvwuRRO8e059T/rw2HFezZxNuN5z
f4muH2sEPwuTjcR1dmp8GyYkk45YJMlqCx3c8vokzxGi6ZYGAxdVie5tl04Nf5EC
qN2Ks+bLSMQfaAftq9SRjtaQ2Y5sslOzpx6fEET6zS7FN8pVoU06AY+eizVTm8BG
d10tkpnEsugwz5gzbmF4wTfwA/IoSw7CEgBFXVFVW8OnJfUrNrUaJMCqnkH08BHz
NOHAWshaAJVw5ZPgjF0G
=PJDx
-----END PGP SIGNATURE-----

--------------enig3F973B8830014FEB74061923--


--===============7452282723274585311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7452282723274585311==--
