From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: i2c for omap5912,help me
Date: Fri, 8 Dec 2006 12:04:28 -0600
Message-ID: <772F5D89C5E0734B8A86D85DFC6A2024055154AC@dlee03.ent.ti.com>
References: <004401c71a95$3faead50$420aa8c0@yfliwei>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <004401c71a95$3faead50$420aa8c0@yfliwei>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?gb2312?B?wO7n4g==?= <coffeeyu531@126.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

 Does this help?

 http://oskfordummies.hp.infoseek.co.jp/howto/led.html=20

 Regards,
 Ishigami

-----Original Message-----
From: =C0=EE=E7=E2 [mailto:coffeeyu531@126.com]=20
Sent: Thursday, December 07, 2006 10:51 PM
To: linux-omap-open-source@linux.omap.com
Subject: i2c for omap5912,help me

Hi ,
=20
 I'm using an omap5912 and would like to light the led D3=20
on the board thru the i2c driver.
Now I  can not see nothing in /proc/sys/dev/ and  /dev,
but I can see there is something about
 i2c in /proc/bus/. I can not open the file,Could there
be something wrong with my opening the dev file ? I hope
there is someone who knows my problem? Thanks in
advance.
 Below are  the debug msg aswell as the code.=20

  int adapter_nr =3D 0;
  int file;
  char filename[20];=20
  sprintf(filename,"/dev/i2c-%d",adapter_nr);
   if ((file =3D open(filename,O_RDWR)) < 0) {
     printf("Error Opening File\n");
     exit(1);
   }

the file value is allways 1,Who can help me?Thanks!
