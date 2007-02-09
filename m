From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: omap2430sdp fb and lcd - unable to see anything
Date: Fri, 9 Feb 2007 09:42:24 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47081005@dlee13.ent.ti.com>
References: <8bf247760702090510y4e41d2feqc71070783f516e2f@mail.gmail.com>
	<8bf247760702090643u72e38ae4hf4243e16db64f1f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sriram,
=20
Can you just list the set of files that you are trying to port from =
2.6.14 to 2.6.19?
=20
Yes, you have to enable power for UI board, its from T2 LDO. Please =
refer to power_companion.c & omap2_disp_out.c
=20
Regards,
Khasim

________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of Ram
Sent: Fri 2/9/2007 8:43 AM
To: linux-omap-open-source@linux.omap.com
Subject: omap2430sdp fb and lcd - unable to see anything



Hi,
   Have been trying to get linux-2.6.19-omap1 working with OMAP2430SDP.

   Im using the code 2.6.14-7 (with linux.omap.com) as a reference.

   I have tried to port frame buffer driver and lcd driver to linux =
2.6.19

   Im able to do
         $ cat /bin/busybox > /dev/fb

  But i dont see anything on the LCD. I also notice that the LED "CPLD =
Done"
is not on.
  The LED, is right below the LCD panel on the SDP.

  Im not sure if the LCD panel is powered-on?.

Please Advice, do let me know if im doing something im not supposed to =
do.

Appending boot messages does this makes sense?.
I see the fb and lcd getting registered.

have a doubt on power and clock settings. not sure, hence the mail


Please advice



Regards,
sriram
