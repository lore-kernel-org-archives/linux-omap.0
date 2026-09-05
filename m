Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C4485CC8
	for <linux-omap@vger.kernel.org>; Sat,  5 Sep 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611110; cv=none; b=R8aE4OgDiGXDF5/6ZGgNv0n1bonIU6LSyhqFVE4jK9aWjjGt4mQxDT4E+ofvPOdxIX2XmvfJtJy5Yzk0lmlcfXg8zExM8hdHXVpYUJAC1hBCHOr70RLaCmtWxMp+L3hfhSh4P90fL4wVhf8cwYTvYGKAdFbHyfjsVmimkx+DoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611110; c=relaxed/simple;
	bh=7FDVdWewnpg54EuU9ucLHlKJB14SIxO1UfQn4Ib5/nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfTsNZRCv4g87Z6TefJydA3YAWOX0kqXxVvHgwwvQzlJy5mqzJM3eo/wYHIkTIf2+KelbU9AVab2jNCfpLMcU88/LiwtiRDA/7o1JUCVWpul4VF2+sPaR9yw20ypnndseMTqcDUwMW1laGr/6r3ughsgTKDiHlFKY/C8DEyWMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIppZdlg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIppZdlg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482f9309813so1750571f8f.1
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2026 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611107; x=1789215907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6jyEkPF9QjFxAuLX7joeVpRJHHAcWObix5FAN064Z/Y=;
        b=NIppZdlgCAPQoL9WttB6AfgdCQRal5wFr5AQEERkH6DIce3Ho5ioUFe8AsyN6mXF9X
         WTTLdt+yXULuDEsYVloplBF5n/DkRxynvvEDu8QzFlq983/ccKEtRGDoYtIGDzuhDQGy
         szamzdSZUWmm0H2dVvJyYZ2SAxK2uruAjLFEeTSx//uFzCfaqKK9B8LjdX2yIvIgFQw/
         opc6X+p+Qz/vZykF3mkz59Wkj+ik/zH4gU6pkTwM6mRUq9BCOmXeuPQPy5IIZlEY3Gbp
         OnF1+6TLj7aJtaC9kVDZRK7DgVMt72mQKzvVKHsXAPYlL707BaFhHimeyEAaI0zC6f0s
         8FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611107; x=1789215907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jyEkPF9QjFxAuLX7joeVpRJHHAcWObix5FAN064Z/Y=;
        b=H+d1IQsxOu3Ch7JPPJv7W7OdbzDn4loJbVnYWj6+6pcfoz/yxZ9eH5JTipzScmBFRC
         p3v3u9KWFs1mmZHofuBXj1S5OphD+GwNGmR1j6OGD+fTOQUTreH3NmpZljCBIztojtb8
         Qj5ngXgMBV1rrpQAxu8PahB3Cj+jcM9ByouIOYad9Ho2tL8HJO348v5JnRkjykh25c20
         gmsi2u/fWpA100ycyA5Qi9t9U1FXmrZGaxxmNTVU1W1EK05ia3mJ85Wg8i5S5FH9v25S
         LkDumGHM/0TPzRG2oUSwjti6+8Qz1cQovfBseMUxgaCdaJLrPE5lzOfXKWZFcgN1PQBu
         mQPA==
X-Forwarded-Encrypted: i=1; AKwUvBzdFhoIRYbYMjylUAYH9zpF/iz5EcfmJ47xas8qAShpn5qm5XuxQKHOhDZQ7z2RxJolPXk+JFWalt+3@vger.kernel.org
X-Gm-Message-State: AFuF++kRib30U+7S1yCTyHBmsXTpR/QQKeUdMXE9WxLfEuCzHM+JKO3a
	IIxcDLvVUS0oUz5yJoebNUz3Cj66ZZZ+4vGikseJADaO5aTThpgjFYmf
X-Gm-Gg: AYBFou3iQ/9GlBWIHv/Jm+tkjudesEloFXlglCkLimSwRJmxd+R8xGLl42L5eYvFBM2
	B0q8nGTjh5YYUIogFWXhBLQ7B2fkMMHq6qE7Y7qfLmWGncFpArDKk2W6xfDvd9togpQlNY+NYqy
	cVCB3Ur1GeRw3sbsHppaJkrrQTpqLeUxvSxKbwqrv9eYEfXDZfmKqtNQgK547ZHqOcVkNYbSerP
	6xv4boJfs125YGvYGWFcRw/pCNpk81/TN7GY+2cmIikbjIcMJyxAn2BHOffOF47YTZk/coLcFvl
	uoypq1pOBLtIRTDG81ASGKg0FhJO3nURdTAm6XCNmA04INd00wu9MXYwzF2eUIz+GIeskeDWNvp
	bsnijvUqb9mK8SNAW32Tiow9KiDKnz3Fv1egWIMppMGKeRVuJytRkocg56EyP/BzX2GJqNIQ/t1
	e4kIGs8aEHHGHHRWkqlPXDJUVI1z8OXt8TedeQdKcOrFjVRg+c3Y/pTVK3/mZQmqsoGXWywmkAy
	N6oEhPnQ8Vto19xmKRhbdSfkLt2wU/H5E92jVTPd4c6UeO0gvX7h9kRgIcfbrGSQIIqss6enta7
	wmtAB2T1tPfNNpsrO8rN8gkELfCDNKRr8L9Zy5Ug043nGKVCmh2bn+VFjYnbjtld
X-Received: by 2002:a05:6000:41db:b0:485:82f9:44b4 with SMTP id ffacd0b85a97d-4858709c044mr15925496f8f.7.1788611106580;
        Sat, 05 Sep 2026 05:25:06 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588392b3esm15549562f8f.12.2026.09.05.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:25:05 -0700 (PDT)
Date: Sat, 5 Sep 2026 14:25:02 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, 
	Tony Luck <tony.luck@intel.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Michael Schmitz <schmitzmic@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 0/9] docs: kernel-parameters: Remove ten entries for
 parameters that no longer exist
Message-ID: <apwIbDr0kyquxVoL@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <693303da-350b-4295-b008-6fee8bb4c591@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693303da-350b-4295-b008-6fee8bb4c591@app.fastmail.com>

On Sat, Sep 05, 2026 at 12:12:51PM +0100, Arnd Bergmann wrote:
> On Sat, Sep 5, 2026, at 11:46, Karl Mehltretter wrote:
> > kernel-parameters.txt still documents ten boot parameters whose parsing
> > code was removed with the drivers or platforms that used them, one of
> > them (atarimouse=) since before the git history. One patch per
> > parameter, each with a Fixes: tag for the commit that removed the
> > parser, so the maintainers of that area are on their own patch only;
> > the two pata_legacy module parameters share the last one. Each entry
> > was checked with git grep for its __setup(), early_param() and
> > module_param() handler and with git log -S for the removing commit.
> 
> These all look good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> If you have a script that you can easily run on another tree,
> could you send me the script or the output for this one?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove
> 

Thanks for the review! Yes, here is the script, improved a bit since the
series was made.

It does not show anything on your branch though. board-remove at
c12d647b0229 removes 40 registrations, none of them a documented
parameter that loses its parser. The three documented names among them
(debug, irq, noalign) are still registered by other code.

Run it with
    check-kernel-parameters.py -C ~/soc --diff 8d3ae59288f1 board-remove

Its report mode turned up a second batch of stale entries on mainline
(r128=, mga=, i810=, tdfx=, smart2=, shapers=, hd=, goldfish, js= and a
few more), which I might send later.

Thanks
Karl

The script:

#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0
"""Find documented boot parameters that nothing parses any more.

Reads Documentation/admin-guide/kernel-parameters.txt at a git revision and
looks for the registration of every documented name in the code at the same
revision: __setup(), early_param(), core_param(), module_param() and friends.
Names without a registration are printed together with whether the name at
least still appears as a string somewhere (cmdline_find_option() style
parsing), so a human can decide. A parameter that was only ever parsed by
hand, without any of the macros, is invisible in both modes.

Usage:
    check-kernel-parameters.py [-C tree] [REV]           report for one revision
    check-kernel-parameters.py [-C tree] --diff A B      names parsed at A but not at B

Runs entirely on git objects (git grep / git show), no checkout needed.
"""
import argparse, re, subprocess, sys

REG = r'(__setup|__setup_param|early_param|early_param_on_off|core_param|core_param_unsafe|late_param|module_param|module_param_unsafe|module_param_named|module_param_named_unsafe|module_param_cb|module_param_cb_unsafe|module_param_call|device_param_cb|module_param_string|module_param_array|module_param_array_named|module_param_hw|module_param_hw_named|module_param_hw_array|__core_param_cb|torture_param|param_check_\w+)\s*\('
LEGEND_STOP = 'Kernel parameters'   # the tag legend ends at this heading, the parameter list follows

def git(tree, *a):
    r = subprocess.run(['git', '-C', tree, *a], capture_output=True, text=True, errors='replace')
    if r.returncode and 'grep' not in a[0]:
        sys.exit(f'git {a[0]} failed: {r.stderr.strip()}')
    return r.stdout

def documented(tree, rev):
    """Return {name: line} for every parameter entry in kernel-parameters.txt at rev."""
    txt = git(tree, 'show', f'{rev}:Documentation/admin-guide/kernel-parameters.txt')
    names = {}
    in_list = False
    for n, line in enumerate(txt.split('\n'), 1):
        if not in_list:
            if line.strip() == LEGEND_STOP: in_list = True
            continue
        m = re.match(r'^\t([A-Za-z][A-Za-z0-9_.-]*)(?:=|\s|$)', line)
        if not m: continue
        name = m.group(1)
        if name.isupper() and '.' not in name: continue     # a stray tag, not a parameter
        names.setdefault(name, n)
    return names

def registered(tree, rev):
    """Return the set of names registered by the parameter macros at rev."""
    out = git(tree, 'grep', '-h', '-E', REG, rev, '--', ':!Documentation', ':!tools', ':!scripts')
    names = set()
    for line in out.split('\n'):
        for m in re.finditer(REG + r'\s*"?([A-Za-z0-9_.-]+)', line):
            name = m.group(2)
            if m.group(1) == 'torture_param':     # torture_param(type, name, init, msg): the type comes first
                mm = re.search(r'torture_param\s*\(\s*\w+\s*,\s*([A-Za-z0-9_]+)', line)
                if mm: name = mm.group(1)
            names.add(name.rstrip('='))
    return names

def string_hits(tree, rev, name):
    """Files at rev that contain the name as a quoted string (manual command line parsing);
    a dotted name is looked up whole first (arm64.nobti style tables), then by its last part."""
    for probe in ([name, name.rsplit('.', 1)[-1]] if '.' in name else [name]):
        out = git(tree, 'grep', '-l', '-F', f'"{probe}', rev, '--', ':!Documentation', ':!tools', ':!scripts')
        hits = [l.split(':', 1)[1] for l in out.split('\n') if l]
        if hits: return hits
    return []

def parsed_at(tree, rev):
    docs = documented(tree, rev)
    regs = registered(tree, rev)
    def ok(name):
        if name in regs: return True
        base = name.rsplit('.', 1)[-1]          # module.param= is registered as module_param(param)
        return base in regs
    return docs, {n for n in docs if ok(n)}

def report(tree, rev):
    docs, ok = parsed_at(tree, rev)
    missing = sorted(n for n in docs if n not in ok)
    print(f'{len(docs)} documented parameters at {rev}, {len(missing)} without a registration macro:')
    for n in missing:
        hits = string_hits(tree, rev, n)
        tag = f'string appears in {hits[0]}' + (f' (+{len(hits)-1})' if len(hits) > 1 else '') if hits else 'NOT FOUND anywhere'
        print(f'  {n:40} kernel-parameters.txt:{docs[n]:<6} {tag}')

def diff(tree, a, b):
    docs_a, ok_a = parsed_at(tree, a)
    docs_b, ok_b = parsed_at(tree, b)
    lost = sorted(n for n in ok_a if n in docs_b and n not in ok_b)
    print(f'documented parameters parsed at {a} but no longer at {b}: {len(lost)}')
    for n in lost:
        hits = string_hits(tree, b, n)
        print(f'  {n:40} kernel-parameters.txt:{docs_b[n]:<6} ' + (f'string still in {hits[0]}' if hits else 'no string left either'))

if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('-C', dest='tree', default='.')
    ap.add_argument('--diff', nargs=2, metavar=('A', 'B'))
    ap.add_argument('rev', nargs='?', default='HEAD')
    a = ap.parse_args()
    if a.diff: diff(a.tree, *a.diff)
    else: report(a.tree, a.rev)
