From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: mcbsp
Date: Tue, 8 Aug 2006 08:00:48 -0500
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBEE6BA20@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Arnold <abo_gwapo@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Is LED connected to McBSP lines and you want to operate them (McBSP
lines) in GPIO mode? This is possible by changing the mux settings of
McBSP lines to GPIO mode and use the GPIO APIs to read and write to
them.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Arnold
Sent: Tuesday, August 08, 2006 3:34 AM
To: linux-omap-open-source@linux.omap.com
Subject: mcbsp

Hi guys,

Is there anyone who knows about mcbsp? Is it possible
to connect a button or a led to it? If yes, how is it
done? Is it the same as programming the gpio? I hope
there's someone who could help me.

Thanks,
Oj

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
