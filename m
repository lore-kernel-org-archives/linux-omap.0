Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795016306;
	b=lIFH0yDZzme/fdLv6N9HJHSaV1AEkMThUga8ha3JGelFOW1QXeD4b8Bd4nY1dJY2Eqwr
	 ANZhhifrDndiM0w9XaLwsZe7Kq84X6RZf6+JueIvQgrKVoEK5+2GWg4r2w6eRPnNqFY0Z
	 ZMtEb/g6BREnS6O2yfZZArrTk4NKrU07/nK61KQQp0TGd41MLO8PWSqp4TpkgIBaPXxg8
	 d6fWB/KELoJuDeacSLWFeMGnv3x/8DooOJu8Gu69S9+S4EyG3vBPZRyTeEqtRk3mL+efC
	 Amz++plecTbwrSRE5GDyQ/Q8WZ0GqIWuxXpu1ZmRrc7T4n/pk61O+Pu3b/sBBXeSKmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016306;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=bHHVOuQhXd2ftrd1exjrxSrMuavmtXgqywzFbhTqz/4=;
	b=gnc1Kx3axVmNcwx0B4DyWP/6zgQ9dparrUuxJFYXq+aIDd+Ni4tdxtrN09Y0cQM6i+n6
	 yA3SWa83d3Z4ViCc0iE4+j8Khq6+s6WwdtbKZId6SDiagCfpT0Z8bMdQjpZBX9ffSWFiT
	 rQOPfI7M/zInbdnJsnYmfaixdFq+UANhMacI96XJbTHoNxEoEXEVaUGod2sOD8Z1//5Ss
	 EckIsGMz4FFbSMVxyx0PfDH9R806U1XxI+NXeR0862qZ4+FTSeM2ipZqA0c4TGYD8jmgb
	 1Cxx9coT39e2BQgwInm0+5a4Jg7qnGHu46POPSuBI1KnbU9nLxzAp8DWpBToQKUGb+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7rnvuqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFC60A2634;
	Wed, 18 Nov 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7rnvuqX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795016306;
	b=MdJY2baT6iZnY7puw01Jy4BBNDvGnek34p+fb3MJlSRoLgEcusnwaed6NBTtctrnYLX8
	 Spf3Xcsdfrzvl9fEsCLhCclkD+vtG92jodoIFBcFwgQwnJsRq4CzLiycq9bDrIg92Wsm0
	 5YFw/uKwv78v5cPZZlybXPbrCxcbkiV+JBvebPH8WdWdBoefLapXg/cz5m4+C+aKjql8f
	 YUsin/D3vZkMy7AjZr+PbHSoH1jolR0nOevPLwc/vGg+f0xrQGclU+AfOALtWvvqSYoOg
	 na2EXHBsCnAwYiIwTtC+U+6KNoXYT1tOIkLs3sIfjsEKGYz9IL/vwvbJRquO3KA9zwA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016306;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=bHHVOuQhXd2ftrd1exjrxSrMuavmtXgqywzFbhTqz/4=;
	b=uROoFuNvBo3qNIIiKYkb0T2n0ukr1kUiwMCzNYw3tUIgR+duSkGPjRawKzd4uQEmHEiD
	 z3YvxHyKFufJGp67T3hExZ8Q/0jiBjOqQ3Qb8z5cbNF1OyZe0ksaudGabGO29yLHhG/q/
	 udoWa7sQ5OrSe5oCeDVShjsZvsaEZ+mZJqqjP6ZGB56trwbTuLxXFbw5gjDpmOmdPgsUk
	 3vj22e3ksWV4Pt2qdS3nxKVKxLlukcozKn6MkbqHMomorv5BMA8VUdpS9Wpr8Cjl2ZY7q
	 0oSfk4YGCOrZW/4Y5sKI7M43ZPoyyUwfLJKH7Aab1UL/LfMRUWv4UqCpm1BpD8c0q6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3FFE71F000C5;
	Wed, 18 Nov 2026 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795016306;
	bh=bHHVOuQhXd2ftrd1exjrxSrMuavmtXgqywzFbhTqz/4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=O7rnvuqXzHz+ETSgq5/PGM8HSAhNsxhg+Psf+RDyJCP/IIcnrl8EMuHhLtgZErWDX
	 d8RnEp8FE1pAECfbYe6gePdQgqE+HhrZqWZ5l2z8eZzbUZMg23pQ6qQ1WkLyuDiH8v
	 M0mFuhQYsbR3oJ6QqnkZlA6n5jrI/JvupDP+CxjIqoto2XtuQjVelNC5ZpXtwpA9O7
	 bTcM6p76mKoe/X3VpBGmL6rNpVIUbNX2PGLWjAHagGsAt79XSr1RY6NFG/PIaCTU6R
	 FbbqQG/FUfHYYYVm4eYTMKp3Y7NgRtnH65tpQE7QBE5/2I00pVzOIhCd2IQ8vHbKYG
	 G3YOkH1T6qL+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 956E74AE12;
	Wed, 18 Nov 2026 15:38:25 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 15:38:25 +0000
Subject: [PATCH] remoteproc: omap: Fix cleanup after timer start failure
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-omap-rproc-v1-1-c2824060fd10@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHDG/WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0ML3fzcxALdooKi/GTdJGNjQxNLcxMz40RzJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAJiaNWRuAAAA
X-Change-ID: 20261118-omap-rproc-b331497463a7
To: andersson@kernel.org, mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795016304; l=2382;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=5CaSvn4PiRTxlXy+sXlFYuB0nwYQd2B6binwsJAROTE=;
 b=FcG4ouxfwBkbl5ONLABK/xpQ+rRul8yhXniLdOWoNT8bFvI26PaqOSNpexnFmOP/rfMFO+J4b
 5Gf2XbdaEynCI8NGMVOIpSqhIRgMOtP1hPyuDi+YwMMuV4ViuefbaiX
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

When omap_rproc_start_timer() fails in omap_rproc_enable_timers(), the
error handling has three problems.

First, the stop loop also stops the timer that failed to start:

	while (i >= 0) {
		omap_rproc_stop_timer(&timers[i]);
		i--;
	}

omap_dm_timer_start() drops its runtime PM reference when
pm_runtime_resume_and_get() fails, so stopping that timer calls
pm_runtime_put_sync() once more than it should.

Second, the loop leaves i at -1 and then jumps to put_node, which falls
through to free_timers:

	while (i--) {
		...
		omap_rproc_release_timer(&timers[i]);

With i == -1 the condition is true and the first iteration uses
timers[-2]. The loop then keeps going through negative indexes.

Third, when configure is true, put_node puts np again. The parse loop
already put every node it got, and np still points at the last one, so
that reference is dropped twice.

Only stop the timers that were started. On resume (configure == false)
return the error and keep the timers: they still belong to the driver
and are released later by omap_rproc_disable_timers(rproc, true). On the
first start (configure == true) release all the timers that were set up
and skip put_node, since no node reference is held at this point.

Found with a static analysis tool and checked by hand.

Fixes: e28edc571925 ("remoteproc/omap: Request a timer(s) for remoteproc usage")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on arm with clang (W=1, no new warnings). I don't have
the hardware, so the failure path hasn't been run.
---
 drivers/remoteproc/omap_remoteproc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index f52a531877ae..d50f2e993c4e 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -418,11 +418,14 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
 		}
 	}
 	if (ret) {
-		while (i >= 0) {
+		while (i--)
 			omap_rproc_stop_timer(&timers[i]);
-			i--;
-		}
-		goto put_node;
+
+		if (!configure)
+			return ret;
+
+		i = num_timers;
+		goto free_timers;
 	}
 	return 0;
 




