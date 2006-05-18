From: "Marco Candiago" <Marco.Candiago@nicta.com.au>
Subject: RE: Userspace GPIO
Date: Thu, 18 May 2006 14:08:13 +1000
Message-ID: <09D3F703EF3B0A4CBE28449EA9F3D320020AB520@nicta-atp-mail.in.nicta.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Thanks fellas,

I will investigate these options

Cheers,

Marco

-----Original Message-----
From: Juha Yrj=F6l=E4 [mailto:juha.yrjola@nokia.com]=0D
Sent: Wednesday, May 17, 2006 7:49 PM
To: balrogg@gmail.com
Cc: Marco Candiago; linux-omap-open-source@linux.omap.com
Subject: Re: Userspace GPIO

andrzej zaborowski wrote:

> You could create it by modifying one of the drivers already present in
> the tree, I know the Intel PXA hackers have one of these and use it as
> a keypad driver because each key is associated with one GPIO line on
> their boards.

Or you could GPIO switch framework (arch/arm/plat-omap/gpio-switch.c),=0D
which interfaces to user-space using sysfs.  It will need a small amount=0D
of work to operate properly with the platform_data mechanism, though.

Cheers,
Juha


--------------------------------------------------------------------------
This email and any attachments may be confidential. They may contain=
 legally
privileged information or copyright material. You should not read, copy,
use or disclose them without authorisation. If you are not an intended
recipient, please contact us at once by return email and then delete both
messages. We do not accept liability in connection with computer virus,
data corruption, delay, interruption, unauthorised access or unauthorised
amendment. This notice should not be removed.
