From: <sshahrom@micron.com>
Subject: OMAP: Adding Support for 2K nand page support foromap2430
Date: Tue, 18 Sep 2007 15:03:42 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6CF@ntxsjombx02.micron.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AE@ntxsjombx02.micron.com>
	<20070810104326.GX8658@atomide.com>
	<809D758398CC1F49AA8E493528AD4A27014DF6C1@ntxsjombx02.micron.com>
	<20070917191652.GC5614@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070917191652.GC5614@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
I will do that and resubmit.=20
Thanks,
-Shahrom=20

-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com]=20
Sent: Monday, September 17, 2007 12:21 PM
To: sshahrom
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH 2/3] OMAP: Adding Support for 2K nand page support =
foromap2430

* sshahrom@micron.com <sshahrom@micron.com> [070827 09:34]:
> Hi;
> Sorry, I just got back from vacation. The difference between =
omap-nand-flash.c and omap2.c was so much that I thought modify =
omap-nand-flash.c file would cause more confusion. But I am open to any =
suggestion.

Can you please fix the following things so we can apply this:

- Please noCamelCase in linux code
- Some of the code should/could use gpmc.c code
- CodingStyle, see following output from scripts/checkpatch.pl

Mostly stuff that would be a showstopper merging it upstream in MTD list =
anyways. You might want to run checkpatch.pl on all your patches!

Regards,

Tony
