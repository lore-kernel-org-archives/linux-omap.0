From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: 2430 download problem
Date: Tue, 20 Nov 2007 09:25:13 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302A4BEE0@dlee12.ent.ti.com>
References: <000f01c82bd0$41615970$0f01a8c0@jackywang>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <000f01c82bd0$41615970$0f01a8c0@jackywang>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: jacky_wang <jacky_wang@ovt.com.cn>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>     I am working on sdp2430-V4.0.1 development board. I'm=20
> using CSST_SDP2430_v1.4 download my uboot.bin. but whatever=20
> via UART or USB, It always occures "Failed to connect to=20
> target".I connect my serial cable from windows host to the=20
> uart port3(the one close to the LCD") and config the dip=20
> switches like this:
> S4 : OFF  ,  OFF ,  OFF,  OFF,   ON ,   ON,   OFF,  OFF
> S6 : ON   ,  OFF ,  OFF,  OFF,   OFF,   OFF,   OFF,  ON
> S8 : ON   ,  ON   ,  ON   ,  ON   ,   ON ,   OFF,   ON,  OFF
> S9 : ON   ,  OFF ,  ON   ,  OFF,   ON ,   ON,   ON,  OFF
> S10 : ON,  ON   ,  ON   ,  ON   ,   --,      --,    --,     --
>=20
> Does anyone encounter the same problem?  Any suggestions are welcome.=20


I have not encountered this problem with the V4.0.1 board. Please note
that only UART download works on the V4.0.1 board. Your dip switch
config above looks correct assuming switches 1-8 go from left to right
as below:=20

Switch	1	2	3	4	5	6	7	8=09
S4 : 		OFF	OFF	OFF	OFF	ON	ON	OFF
OFF
S6 : 		ON	OFF	OFF	OFF	OFF	OFF	OFF
ON
S8 : 		ON	ON	ON	ON	ON	OFF	ON
OFF
S9 : 		ON	OFF	ON	OFF	ON	ON	ON
OFF
S10: 		ON	ON	ON	ON	--	--    --    --

Please make sure that you are using a NULL modem cable and not a regular
serial cable.=20

Regards
Jon
