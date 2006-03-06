From: "Marco Candiago" <Marco.Candiago@nicta.com.au>
Subject: iUSBLoader.out load failure
Date: Mon, 6 Mar 2006 15:31:14 +1100
Message-ID: <09D3F703EF3B0A4CBE28449EA9F3D320477AB4@nicta-atp-mail.in.nicta.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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


I realize that this may be a Code Composer Studio issue, but since it is
related to loading and booting my Linux kernel, I thought I might ask
the question here first.
=0D
I have just completed a design based heavily on the OMAP 1510 Innovator
platform.  My intent was to load iboot core on into boot flash, to
enable the client USB connection so I can use Iboot host. I understand
that Uboot may be superior, but as a first step I just wanted to be to
load something into memory.
=0D
Using CCS v2.21 and XDS510USB, I am able to connect to my target system
no problem.  However when I try to load IUSBLoader.out, I get the
obiqutous Data verification failed at address 0x10900000 load error.  I
have verified memory mapping in the CCS GEL file and everything looks
O.K
=0D
I get the identical error on my development platform which I know works.
=0D
Has anyone ever encountered this error or something similar when trying
to load an *.out file with CCS? To OMAP.  If so?  What was your
resolution.
=0D
Any help would be greatly appreciated.
=0D
Thanks,
=0D
Marco =0D


--------------------------------------------------------------------------
This email and any attachments may be confidential. They may contain=
 legally
privileged information or copyright material. You should not read, copy,
use or disclose them without authorisation. If you are not an intended
recipient, please contact us at once by return email and then delete both
messages. We do not accept liability in connection with computer virus,
data corruption, delay, interruption, unauthorised access or unauthorised
amendment. This notice should not be removed.
