Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B58137750
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787142768; cv=none; b=fbg4BbSXpK+x+ZQN2mOTEJGaD8Yai6J7HM+H8cn7J19AMSVVUS9DqmCG6gDGN1mP3wAovUAzVDbJCeArC83dBTiuBNqNzQWKWnrmfM7bTiFUF7F+36CjHLIN8RojbF79VUri/CsKjzA47PpddtF/nh438WP22Ys3MBhmm/cbBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787142768; c=relaxed/simple;
	bh=Qv/Y2/4+5KC9Xpuu4KHuVa8r+6OMl1nd1n6bDxiaXk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRrUXRT2KWc1R/1z4xaUuPU4yhZ4D3tQykQlHn0WMYnBdVajBsdm/xmaPXhv6V22c58eAGYRatBWBsBjJ7hJKbqTVtzsjH7WEAkYAy56bOsvFAI3ZGQcunuRFtgaxugnCm6ThWq4mYNO86cA651vYs9CGanrTXWqhY/nhM7kwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so659786241.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 05:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787142765; x=1787747565;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9+R+LcOTcS+vIIZ4NxuztMgKx1+fTkhDLAPmPl8GYBU=;
        b=k945idXki1FS/wRw9VPlGhMrgj0it8UsVtgaHwG/KdLtEG9/Qktg5Qy8ZavGdoYHxK
         BRLhBANMIYZyAMAXok3B1zNrsOpYW3v4WNeNczK1ItuaVlwHYBG5vA1f4WqB1keJ/eDO
         q2iPVhN7jW6SqWgGCi/8Uy38yUQd9Y5n3znNJm6WIScLDtcqW0jMJ1wleXG+BVnH76ac
         IMfgIJ9z51IfBWaE+6B6SYuvn5KWH71I73AJtgbWgkaXLHE/UXRP7zkI3cD1GBpnGo2L
         RI1z9hIN//tlxkZwfEO1mb/DM7vkywBWhVVI9hTVTtnNzQ2AwNxdpSN0Zz7M9w6omJAJ
         yNPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr45GGrJNryQjtgN7/JyJK2ThTPA/EAsrE2VZEyX34fVE9iI6fc/mqQepuOjxSpQ1vk1V0y701/olOI@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNDGiUepMYlYxQUCvEUexjw/2vgIsw+XO64Tppwi3cFedX3rA
	ckk8OFdGU2XbumEspJPPHKcmKrMJmyYNUKTkJZgBGyjPgajvexukHHyAzP2g9QS4tk0=
X-Gm-Gg: AR+sD109XhbHwQW6XDc04f/Bz4tpsh8icWnEtzIAqqK5yQWQawLSpH/5OIsL43F7kf2
	ujPscO4Cq6XpQOcqQdjsq/Hv6pO+mg/93lnkOOoCzzpw3/tAISUbaAk3pS/RUD4dKNPOD2CmDuW
	dyuuiqQdAjoF9dYAtuorPP8s4bYGUsxPKagObSJ+4VtYCVz0THseMQLFaBAf6SMOj1HEGlWuppw
	91MC8T7YeaBrKnjDQU+zw87Ixr9caZFhAf/5ws1jm52PE3v6Xoqaga6+g+iYokFJJNr6FgjsUrb
	2dXHWAnLSb/D131pr5nB8DdAYS/+WqA8VDV92sDYy3i8KGaQ5I0ywhuRlaF05dTXHpqR6yOG52g
	jsVXzfPTZhqiy1fGQ/saygDKhwhBxD0PraMfhq7vcAyFz49QhE+aZhCdwY6j073CHuoPOl3qR/b
	FsYmlEqc92o9wvB40o9nsaaQxcJiO0t7nRyjQNsv3N/M20Ob9TGdtdjliCAUMIAjVPd7nzrjknV
	/yDRhIGHGp3dbWJkTGJnoeH0Q==
X-Received: by 2002:a05:6102:8603:20b0:774:f67e:c05a with SMTP id ada2fe7eead31-777ddd91d47mr819389137.9.1787142764917;
        Wed, 19 Aug 2026 05:32:44 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c4e93f0e5sm1921866241.11.2026.08.19.05.32.44
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 05:32:44 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9674d727c0aso1461397241.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 05:32:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpKBFWtoSEGol7z6Ni3Fsv2sxezcc11orTh2r4VssN36HiVhOemO6r+4QE0aJFwU711JORAo5blQm3L@vger.kernel.org
X-Received: by 2002:a67:f70c:0:b0:744:f493:f09a with SMTP id
 ada2fe7eead31-777df717eedmr779634137.14.1787142763870; Wed, 19 Aug 2026
 05:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
 <CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com> <DKSOGEFQ4RJA.3LEW2Y8991H17@bootlin.com>
In-Reply-To: <DKSOGEFQ4RJA.3LEW2Y8991H17@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 14:32:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfFZ0P9Na-yD9EzBaUqkyiwjo8byxA2MouBt1DM8xQtA@mail.gmail.com>
X-Gm-Features: AcwNN1WiRacvOcIOzMfczjrj_nsgZ0XtEzfTjL0-_yXC_-RpdT5wt5ALyRzFeP0
Message-ID: <CAMuHMdVfFZ0P9Na-yD9EzBaUqkyiwjo8byxA2MouBt1DM8xQtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Tony Lindgren <tony@atomide.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

On Wed, 19 Aug 2026 at 07:39, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
> On Tue Aug 18, 2026 at 6:02 PM CEST, Geert Uytterhoeven wrote:
> > On Mon, 27 Jul 2026 at 09:44, Mathieu Dubois-Briand
> > <mathieu.dubois-briand@bootlin.com> wrote:
> >> Resolve parent clocks by their index into the device tree "clocks"
> >> property rather than matching names as strings. Name-based matching is
> >> fragile because a clock's "clock-output-names" value in its provider
> >> node can differ from the name used to reference it in a consumer node,
> >> and because names must be globally unique across all clock providers.
> >>
> >> On AM335x, this caused broken clock trees where some clocks failed to
> >> enable because their parents could not be found.
> >>
> >> Replace of_clk_parent_fill() with a clk_parent_data array that sets
> >> .index to the array position.
> >>
> >> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> >> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> >
> > Thanks for your patch, which is now commit 667f420c09f1417c ("clk: ti:
> > mux: resolve parent clocks by DT index, not by name") in clk/clk-next.
> >
> > This breaks booting BeagleBone Black for me: I don't get any output
> > on the serial console, even with "earlycon keep_bootcon".  When the
> > watchdog kicks in (or on kernel panic?), the system reboots.
>
> Sorry for that!
>
> It's a bit unexpected, as the beaglebone black was one of my test
> platforms and I didn't see any issue.
>
> > Reverting this commit fixes the issue.
> > After reverting, I added debug code to print all parents, and compared
> > them to the DTB, but didn't see any discrepancies.
> >
> > Your similar change to drivers/clk/ti/composite.c does not cause any
> > issues for me.
> >
> > Do you have a clue?
> > Thanks!
>
> Can you describe what bootloader and device tree you are using for your
> tests? Any specific configuration?
>
> On my side, I have:
> - BeagleBone Black Wireless A5
> - am335x-boneblack-wireless.dtb
> - U-boot 2025.10-ti-g6825d60bea17. Maybe I should try with u-boot master
>   branch.

BeagleBone Black Rev C3 (by Seeed Studio)
am335x-boneblack.dtb
Stock U-Boot SPL 2019.04-00002-g31a8ae0206 (May 13 2020 - 09:26:17 -0500)

I am using my own config.

With omap2plus_defconfig and multi_v7_defconfig, it does boot.  However,
this commit does have an impact on /sys/kernel/debug/clk/clk_summary:

--- summary-7.2.0-rc2-00106-g0d4d262c1664       2026-08-19
10:56:51.622275674 +0200
+++ summary-7.2.0-rc2-00107-g667f420c09f1       2026-08-19
10:58:13.929823890 +0200
@@ -77,10 +77,14 @@
 clk_summary:

deviceless                      no_connection_id
 clk_summary:                clkdiv32k_ck         0       1        0
     32786       0          0     50000      Y
deviceless                      of_clk_get_from_provider
 clk_summary:

deviceless                      no_connection_id
-clk_summary:                   clk-24mhz-clkctrl:0000:0 0       4
   0        32786       0          0     50000      N
   deviceless                      clkdiv32k_ick
+clk_summary:                   clk-24mhz-clkctrl:0000:0 0       5
   0        32786       0          0     50000      N
   deviceless                      clkdiv32k_ick
 clk_summary:

deviceless                      of_clk_get_from_provider
 clk_summary:

deviceless                      of_clk_get_from_provider
 clk_summary:

deviceless                      no_connection_id
+clk_summary:                      wdt1_fck       0       1        0
     32786       0          0     50000      Y
deviceless                      wdt1_fck
+clk_summary:

deviceless                      no_connection_id
+clk_summary:                         l4-wkup-clkctrl:00d4:0 0       1
       0        32786       0          0     50000      N
             44e35000.target-module          fck
+clk_summary:

  deviceless                      no_connection_id
 clk_summary:                      l4-rtc-clkctrl:0000:0 0       1
   0        32786       0          0     50000      N
      44e3e074.target-module          fck
 clk_summary:

deviceless                      no_connection_id
 clk_summary:                      l4ls-clkctrl:0074:18 0       2
  0        32786       0          0     50000      N
     4804c000.gpio                   dbclk
@@ -297,17 +301,13 @@
 clk_summary:       l4-cefuse-clkctrl:0020:0      0       0        0
     24000000    0          0     50000      N         deviceless
                no_connection_id
 clk_summary: virt_19200000_ck                    0       0        0
     19200000    0          0     50000      Y   deviceless
          of_clk_get_from_provider
 clk_summary:
                                                 deviceless
          no_connection_id
-clk_summary: clk_rc32k_ck                        0       2        0
     32000       0          0     50000      Y   deviceless
          of_clk_get_from_provider
+clk_summary: clk_rc32k_ck                        0       1        0
     32000       0          0     50000      Y   deviceless
          of_clk_get_from_provider
 clk_summary:
                                                 deviceless
          no_connection_id
 clk_summary:    gpio0_dbclk_mux_ck               0       1        0
     32000       0          0     50000      Y      deviceless
             no_connection_id
 clk_summary:       l4-wkup-clkctrl:0008:18       0       2        0
     32000       0          0     50000      N         44e07000.gpio
                dbclk
 clk_summary:

44e07000.target-module          dbclk
 clk_summary:
                                                       deviceless
                of_clk_get_from_provider
 clk_summary:
                                                       deviceless
                no_connection_id
-clk_summary:    wdt1_fck                         0       1        0
     32000       0          0     50000      Y      deviceless
             wdt1_fck
-clk_summary:
                                                    deviceless
             no_connection_id
-clk_summary:       l4-wkup-clkctrl:00d4:0        0       1        0
     32000       0          0     50000      N
44e35000.target-module          fck
-clk_summary:
                                                       deviceless
                no_connection_id
 clk_summary: clk_32768_ck                        1       1        0
     32768       0          0     50000      Y   deviceless
          of_clk_get_from_provider
 clk_summary:
                                                 deviceless
          no_connection_id
 clk_summary:    sysclkout_pre_ck                 1       1        0
     32768       0          0     50000      Y      deviceless
             no_connection_id

I.e. wdt1_fck changed its parent from clk_rc32k_ck to
clk-24mhz-clkctrl:0000:0, which is probably not intended?

However, that is not the cause of the crash.  My .config has
CONFIG_INIT_STACK_ALL_PATTERN enabled, so any uninitialized local
variables contain garbage.

> @@ -136,7 +136,7 @@ static struct clk *_register_mux(struct device_node *node, const char *name,
>         init.name = name;
>         init.ops = &ti_clk_mux_ops;
>         init.flags = flags;
> -       init.parent_names = parent_names;
> +       init.parent_data = parent_data;
>         init.num_parents = num_parents;
>
>         /* struct clk_mux assignments

Init is not fully initialized, hence init.parent_names contains garbage
(before, .parent_data contained garbage).
As clk_core_populate_parent_map() prioritizes .parent_names over
.parent_data, the uninitialized .parent_data didn't cause any harm before.

I will send a patch to fix this.  This seems to be a recurring issue:
lots of clk_init_data structures are not fully initialized...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
