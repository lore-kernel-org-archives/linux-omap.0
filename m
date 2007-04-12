From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: HOW TO configure OUTLOOK for inline patches
Date: Wed, 11 Apr 2007 21:20:55 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47A958A7@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47A95875@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47A95875@dlee13.ent.ti.com>
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

Hi all,

Looks like I failed again in sending in lined patches. I have sent =
patches (as attachments) directly to Tony. In the mean time, I figured =
the culprit for my problem. Hope this helps others to avoid doing such =
mistakes.

If you use Microsoft OUTLOOK then to avoid Plain text messages being =
wrapped by the mailer do the following,

In OUTLOOK, Tools > Options > Mail Format > International Options =
"deselect the check box for Auto select encoding for outgoing messages". =

Select Preferred encoding for outgoing messages as Western European =
(ISO).=20

Did a quick test and found it working. Thanks to Google.

Will make use of this in future :)

Regards,
Khasim
