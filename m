From: "Chikkature, Madhusudhan" <x0chikka@ti.com>
Subject: RE: MMC issue on omap 2430
Date: Tue, 19 Sep 2006 09:00:55 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E012EF733@DLEE09.ent.ti.com>
References: <20060919062129.63977.qmail@web54301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20060919062129.63977.qmail@web54301.mail.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: srini kode <srinikode@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I believe you have OMAP2430 ES2.0 silicon version with you. If yes, what
is the card type you are trying to test? Make sure that the card you are
using can work at 1.8v. Dual voltage card would be a good one to test.

Regards,
Madhu

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
srini kode
Sent: Tuesday, September 19, 2006 1:21 AM
To: linux-omap-open-source@linux.omap.com
Subject: MMC issue on omap 2430

Hi,
We are using omap sdp2430 setup with 2.6.10 kernel.=20

We see that the mmc drivers are getting loaded
properly, but the MMC card is NOT being detected. We
are using the slot-1 and see that 1.8v led is lighted.

Has anyone successfully used MMC card on omap 2430. If
yes, can you please let us know if anything needs to
be set/configured. =20

Thanks
Srini




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
