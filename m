From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: OMAP1710 - Accessing audio codec from arm cpu
Date: Mon, 18 Jun 2007 12:40:06 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC0800323F019@dbde01.ent.ti.com>
References: <9057093.1181555121733.JavaMail.root@ps5>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9057093.1181555121733.JavaMail.root@ps5>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lbozzi@tiscali.it, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

If you are able to bypass DSP, then write your own code to access DSP
Mcbsp in the armside to send the audio samples.  HW supports it.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
lbozzi@tiscali.it
Sent: Monday, June 11, 2007 3:15 PM
To: linux-omap-open-source@linux.omap.com
Subject: OMAP1710 - Accessing audio codec from arm cpu


Hi all,

I'm a newbie in omap architectures, so I beg your pardon If my question
has an obvious answer.

I'd like to know if it's possible read/write audio samples in omap1710
(it's a Nokia N80) directly from arm cpu, "bypassing" C55xx DSP. I'm
developing a custom application for such a device but cannot modify DSP
code.

Thanks in advance for your replies,

Best Regards,

--Luciano BOZZI
Naviga e telefona senza limiti con Tiscali    =20
Scopri le promozioni Tiscali Adsl: navighi e telefoni senza canone
Telecom
http://abbonati.tiscali.it/adsl/
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
