From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] To enable I2C-2 for 2430 SDP
Date: Mon, 27 Nov 2006 14:08:58 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7E909@DLEE09.ent.ti.com>
References: <456B3E4C.2060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <456B3E4C.2060300@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

My logic was to keep the existing implementation as is. I don't know if
other boards were using this too (can't be). I wanted to isolate 2430
with other OMAP2 boards (if any). If H4 is the only user, then we can
put "machine_is_omap_h4" instead of "cpu_is_omap2430"

Regards,
Khasim

-----Original Message-----
From: Nishanth Menon [mailto:menon.nishanth@gmail.com]=20
Sent: Monday, November 27, 2006 1:37 PM
To: Syed Mohammed, Khasim; linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] To enable I2C-2 for 2430 SDP

Syed Mohammed, Khasim stated on 11/21/2006 11:31 AM:
> Hi,
>=20
> The attached patch enables I2C-2 support for 2430 SDP. On 2430SDP
> Triton-2 is connected through I2C bus-2.
>=20
> Please do let me know if you find any issues with the same.


-
-	omap_cfg_reg(J15_24XX_I2C2_SCL);
-	omap_cfg_reg(H19_24XX_I2C2_SDA);
+=09
+	if (!cpu_is_omap2430()){
+		omap_cfg_reg(J15_24XX_I2C2_SCL);
+		omap_cfg_reg(H19_24XX_I2C2_SDA);
+	}

IMHO, Bad idea... do we want to handle this carefully? is this mux
correct for all omap2 devices? it would rather be board specific than
CPU specific.. remember that the line is out on multiple pins.. this
might be a bad idea for using the silicon for other boards with a
different pin out...how about muxing it only for h4?? that sounds more
proper here... we assume at this point that all muxing was done in uboot
for 2430?? or should we not be doing it explicitly here??

Regards,
Nishanth menon
