From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 03/20] mach-omap2: smartreflex: world-writable debugfs
 voltage files
Date: Mon, 7 Feb 2011 11:03:15 +0530
Message-ID: <AANLkTinMBQZa+-_T4O1dOZcUGjOM4748J+m_WmEV=LXW@mail.gmail.com>
References: <cover.1296818921.git.segoon@openwall.com> <96a2b24548af3a68fde712c68b49e856e53ea1fc.1296818921.git.segoon@openwall.com>
 <87zkqbjtrd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zkqbjtrd.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vasiliy Kulikov <segoon@openwall.com>, linux-kernel@vger.kernel.org, security@kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 5, 2011 at 04:24, Kevin Hilman <khilman@ti.com> wrote:
> Vasiliy Kulikov <segoon@openwall.com> writes:
>
>> Don't allow everybody to change voltage settings.
>>
>> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
>> ---
>> =A0Cannot compile the driver, so it is not tested at all.
>
> Acked-by: Kevin Hilman <khilman@ti.com>
Also fixes the checkpatch warning:
scripts/checkpatch.pl -f arch/arm/mach-omap2/smartreflex.c
WARNING: Exporting world writable files is usually an error. Consider
more restrictive permissions.
#903: FILE: arm/mach-omap2/smartreflex.c:903:
+	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,

total: 0 errors, 1 warnings, 1028 lines checked

Acked-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon
