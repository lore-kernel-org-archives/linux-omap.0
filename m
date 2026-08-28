Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9019328243;
	Fri, 28 Aug 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921776; cv=pass; b=XZqj5ilak3V8I7krnImuFhnSpgwwHKuhV+gYove2K6sDv8wgsqVvWl8UtKaL+X40/PIWo8jomW0eTkDWS29riz/nwzdSna1wwkQQ2ScIwIFksa1VHSYkxbAUUd89BMOO+DkhEbXKQgp60RTF+XUfXZ7qnYf5MppWypBBalZSDHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921776; c=relaxed/simple;
	bh=DXf7FJ3ZCdTXtZlXqEPqhmQCEWNzCQIHhBpPSCMlx/Q=;
	h=From:Content-Type:Mime-Version:Date:Subject:Cc:To:Message-Id; b=fHr7G3tKAWp2appyjoYToqimL8rkAotxLi6trw6mIjkY3+dowJcnACkhfzbpPYwZJlNa92/CNru3cOTWZ4vsRbiAtvP2sS1nhKV44+XVGvR9hB/x297i23WduoTeCceP8oW6hEpjIxyYdaJ/egK3qYqbRUTgjCMuH05fIXyd7Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=kNsYvz9w; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=SQeIFx+2; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kNsYvz9w";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="SQeIFx+2"
ARC-Seal: i=1; a=rsa-sha256; t=1787921406; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YSt/zhv6UfPubd3hnG3/IhsAAyuB0FC/DVKNycjbf5a8BnRA/Ps6R9g8V7SiOU4SPQ
    Uho4wvrHxOERLewuh72mDPppR0FuAHs8po/7lJVV8R1qbszun+3Hpgz39Y1mcEQrWaZS
    VHZhunPefuK3m0suDeYuR+KWdhiRxivjKa13qubUb10QjRg8Dnw9MHmUG+9iuaHOLn5c
    Y7uLP5NdA1DvU4HRE7lkafmNBWiPhH7pncMOGQ7Q/kIcJgmcrXqiMhegbutgUVU8OZDb
    1l8T+JsXvFv3SQLMD/kSCuBg8pTDnYVVlBciL4G4bMaj0UeMAo7wD4QCa57HffB/P8N1
    k3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787921406;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=cgGl+Ap4qnIwdrgSBfPXcEBcMxukzBkYOFIjzApDzYs=;
    b=DyLVNRTLIdga2kU7qX/l+1i5w+vFfpWpETHr+hGnBPBNa8zzWyRBhpNPRd2+ZuI4NY
    mydtBXoIDIc5EJaEibzHF9hsh8Svfz/icI9+O1vwZrRopJEO8FNFaRaN4k/GtTSxIdtD
    nGmmAfSAdA20/zbisjWzqxYgk217WeTiBqDtC3HVRrVnlxr6b8ZQcyfvBOUoIqTjgtPU
    vpUlNiudiIpgLehv6iU+gtZZvKp7yiVv30EEIQhikN1cixt+GGLY9iWXicG2cjgujujS
    o3D4IcKsAfj9kulVCxAK2VqywoSSWWNNyc0LIvR2ig4S+dRx1Ohjv3/o+DDAMHLd6fPi
    tfIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787921406;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=cgGl+Ap4qnIwdrgSBfPXcEBcMxukzBkYOFIjzApDzYs=;
    b=kNsYvz9whzAeDCMeGREkTd17po/9BU26RKFG9EojJUjPM0IyKw+yztK5mEydvMXyBK
    z/HddyX5pDTWeQZUzDBAgQwjtut+BB+5dh5GgN98BRBGjAoksOgTg4B7q0C2kqGfPbN5
    tY00F7nW3MTrjYxPiF/ablthooorWd3AzNLQATLBc4dp5muPAhi8eM7VDJ24TRdwfcAj
    jURk8prwayXpdkN50S76Gyvd1cD5MfkY8yrjnnSpUSs+qDDzXofEZUXcu+YQhgNTtNIn
    4w0PylRMTqsQHFYuwcHoEHLfSliTsU1dd+eAyZXOsQtyDuhfyLz4M27FBntWJZKH80cy
    t4tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787921406;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=cgGl+Ap4qnIwdrgSBfPXcEBcMxukzBkYOFIjzApDzYs=;
    b=SQeIFx+227w3jW+IUwE3gMgbsTdLvQfDNJp9p4sV0Xh3dFDKcqnwxXp3sUT5BzL8pd
    Yx8zOis7CNtnKL8x3BCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrTi5pcm8iNh03LRKjUUFR0UuLB2QxsamlNRA=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id Qfefb327SCo5sBX
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 28 Aug 2026 14:50:05 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Date: Fri, 28 Aug 2026 14:49:54 +0200
Subject: [REGRESSION] OpenPandora (OMAP3) fails to boot since v7.2-rc1,
 bisected to b8eeeca5545659
Cc: linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Andreas Kemnade <akemnade@kernel.org>,
 letux-kernel@openphoenux.org
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tony Lindgren <tony@atomide.com>
Message-Id: <2013A99A-0502-4128-ACFA-B04886224393@goldelico.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi,
I am seeing a boot regression on OpenPandora (OMAP3) since v7.2-rc1.

A git bisect identified:

b8eeeca5545659 ("clocksource/drivers/timer-ti-dm: Add clocksource =
support")

as the first bad commit.

Reverting this commit restores normal boot operation.

The regression is fully reproducible:
* v7.1: boots normally
* v7.2-rc1 and later: hangs during early boot after about 3 seconds
  after reporting
[    3.631072] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps =
every 65535999984741ns
[    3.643341] clocksource: omap_dm_timer: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 58327039986419 ns
[    3.660430] clocksource: Switched to clocksource omap_dm_timer
* v7.2-rc1 + revert of b8eeeca5545659: boots normally again

What caught my attention is that OMAP already has an existing DMTimer
clocksource implementation in timer-ti-dm-systimer.c, introduced by:

52762fbd1c4778 ("Add support for using the TI Dual-Mode Timer as a =
clocksource")

while b8eeeca5545659 adds another clocksource implementation to
timer-ti-dm.c.

The commit message and patch series state that the driver automatically
selects the first timer marked with the "ti,timer-alwon" DT property and
registers it as a clocksource/sched_clock.

I have not determined the failure mechanism, but the bisect result and
successful revert strongly suggest that the new DMTimer clocksource path
conflicts with the existing OMAP3 timer setup.

Therefore, I would like to ask:
* Is the new timer-ti-dm clocksource intended to coexist with the
  existing timer-ti-dm-systimer clocksource implementation on OMAP3?
* Is b8eeeca5545659 expected to be active on OMAP3 systems?
* Has this combination been tested on OMAP3 hardware?
* What is the solution?

If helpful, I can provide more details or test reports.

Thanks,
Nikolaus Schaller=
