Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E83A6410;
	Thu,  9 Apr 2026 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727227; cv=none; b=gO3lGKsvkqMVXu4yqeu8DnJgp2KCWj+aReEOQR6EUr5CJvSH0Vk1kaygkmN6YxIK8a5LUN/RhZzEg/uR5d9gJg04ZQ2bBkRqlkPw5hI/raZe9B0gXqMSRkrKSZ7fld7+8j4qPOvamA3cbX/tXlen8CzE5ZJDjiYoZZ3VlrMIJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727227; c=relaxed/simple;
	bh=SnYznuw5TIZOy509WfsElV3Mi82BzEN6clADK9GcpVQ=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=eyJS4Z4M6RiUCyDWKScrBa9VocrysVXMQi5CngmLdOglBJlRQ/iLzAzcsvdnF7WpFxclaf0//bAsECBU3YQM4u8Eh/QOOjCPsjSwAKduDcvh+nTrUwO7mGBfUFORQOIh/6U7lDNQaEIhb9WeQl9wI5SfayDmeY2F7XHWT6AkoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d9fc75233f711f1aa26b74ffac11d73-20260409
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e5355927-ba50-40cd-a537-64e80443a3bc,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:9b714985cd9beeb8a954a62bdc96700d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|898,TC:0,Content:0|14|51,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: EECD734AD38344E9AF573D7D83B8AA93
X-UUID: 2d9fc75233f711f1aa26b74ffac11d73-20260409
Received: from node4 [(10.44.17.112)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1912020147; Thu, 09 Apr 2026 17:33:34 +0800
Received: from node4 (localhost [127.0.0.1])
	by node4 (NSMail) with SMTP id F20E21200BD8F;
	Thu,  9 Apr 2026 17:33:33 +0800 (CST)
Received: by node4 (NSMail, from userid 10001)
	id EB32D1200BD8D; Thu,  9 Apr 2026 17:33:33 +0800 (CST)
From: =?UTF-8?B?5pu+57qi546y?= <zenghongling@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBmYmRldjogb21hcDI6IGZpeCBpbmNvbnNpc3RlbnQgbG9jayByZXR1cm5zIGluIG9tYXBmYl9tbWFw?=
To: =?UTF-8?B?bGludXgtb21hcA==?= <linux-omap@vger.kernel.org>,
	=?UTF-8?B?bGludXgtZmJkZXY=?= <linux-fbdev@vger.kernel.org>,
	=?UTF-8?B?ZHJpLWRldmVs?= <dri-devel@lists.freedesktop.org>,
	=?UTF-8?B?SGVsZ2UgRGVsbGVy?= <deller@gmx.de>
Cc: =?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?emhvbmdsaW5nMDcxOQ==?= <zhongling0719@126.com>,
	=?UTF-8?B?a2VybmVsIHRlc3Qgcm9ib3Q=?= <lkp@intel.com>
Date: Thu, 09 Apr 2026 17:33:33 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <6q0bxq79jlfn-6q0hlwi0fps4@nsmail8.2--kylin--1>
References: 44ec798c-7b7e-42f4-8e99-a34e49db7dbf@gmx.de
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Thu, 09 Apr 2026 17:33:33 +0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-6t35ut7s8ime-6t3a3xxuelvr
X-ns-mid: webmail-69d7726d-6qms4nqp
X-ope-from: <zenghongling@kylinos.cn>
X-receipt: 0

This message is in MIME format.

--nsmail-6t35ut7s8ime-6t3a3xxuelvr
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+WWVzLCB0aGF0J3Mgb2sgISBUaGFuayB5b3UgZm9yIGFwcGx5
aW5nIHRoZSBwYXRjaCBhbmQgZm9yPGJyPmNvcnJlY3RpbmcgdGhlIGF1dGhv
ciBuYW1lLjwvcD4KPGRpdiBpZD0ic2lnbmF0dXJlVG9wIj48L2Rpdj4KPGRp
diBpZD0iY3MyY19yZSIgc3R5bGU9Im1hcmdpbi1sZWZ0OiAwLjVlbTsgcGFk
ZGluZy1sZWZ0OiAwLjVlbTsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCAjY2Fj
YWNhOyAtd2Via2l0LXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7IC1tb3otdXNl
ci1tb2RpZnk6IHJlYWQtb25seTsgLW1zLXVzZXItbW9kaWZ5OiByZWFkLW9u
bHk7IC1vLXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7Ij48YnI+PGJyPjxicj4K
PGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogI2Y4ZjhmODsgcGFkZGlu
ZzogOHB4IDEwcHg7IGZvbnQtZmFtaWx5OiBNaWNyb3NvZnQgWWFIZWk7IGZv
bnQtc2l6ZTogMTRweDsgY29sb3I6ICMwMDA7Ij48c3Ryb25nPuS4uyZuYnNw
OyZuYnNwOyZuYnNwO+mimO+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX3N1
YmplY3QiPlJlOiBbUEFUQ0hdIGZiZGV2OiBvbWFwMjogZml4IGluY29uc2lz
dGVudCBsb2NrIHJldHVybnMgaW4gb21hcGZiX21tYXA8L3NwYW4+IDxicj48
c3Ryb25nPuaXpSZuYnNwOyZuYnNwOyZuYnNwO+acn++8mjwvc3Ryb25nPjxz
cGFuIGlkPSJjczJjX2RhdGUiPjIwMjblubQwNOaciDnml6UxNjoyOTwvc3Bh
bj4gPGJyPjxzdHJvbmc+5Y+R5Lu25Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9
ImNzMmNfZnJvbSI+SGVsZ2UgRGVsbGVyPC9zcGFuPiA8YnI+PHN0cm9uZz7m
lLbku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY190byIgc3R5bGU9
IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsiPmxpbnV4LW9tYXAsbGludXgtZmJk
ZXYsZHJpLWRldmVsLEhlbGdlIERlbGxlcjwvc3Bhbj4gPGJyPjxzdHJvbmc+
5oqE6YCB5Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9ImNzMmNfdG8iIHN0eWxl
PSJ3b3JkLWJyZWFrOiBicmVhay1hbGw7Ij5saW51eC1rZXJuZWwsemhvbmds
aW5nMDcxOSxrZXJuZWwgdGVzdCByb2JvdDwvc3Bhbj48L2Rpdj4KPGJyPgo8
ZGl2IGlkPSJjczJjX2NvbnRlbnQiPk9uIDQvMi8yNiAxMTozNCwgemVuZ2hv
bmdsaW5nIHdyb3RlOiAmZ3Q7IEZpeCB0aGUgd2FybmluZyBhYm91dCBpbmNv
bnNpc3RlbnQgcmV0dXJucyBmb3IgJyZhbXA7cmctJmd0O2xvY2snIGluICZn
dDsgb21hcGZiX21tYXAoKSBmdW5jdGlvbi4gVGhlIHdhcm5pbmcgYXJpc2Vz
IGJlY2F1c2UgdGhlIGVycm9yIHBhdGggJmd0OyB1c2VzICdvZmJpLSZndDty
ZWdpb24nIHdoaWxlIHRoZSBub3JtYWwgcGF0aCB1c2VzICdyZycuICZndDsg
Jmd0OyBzbWF0Y2ggd2FybmluZ3M6ICZndDsgZHJpdmVycy92aWRlby9mYmRl
di9vbWFwMi9vbWFwZmIvb21hcGZiLW1haW4uYzoxMTI2IG9tYXBmYl9tbWFw
KCkgJmd0OyB3YXJuOiBpbmNvbnNpc3RlbnQgcmV0dXJucyAnJmFtcDtyZy0m
Z3Q7bG9jaycuICZndDsgJmd0OyBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qg
cm9ib3QgJmx0O2xrcEBpbnRlbC5jb20mZ3Q7ICZndDsgU2lnbmVkLW9mZi1i
eTogemVuZ2hvbmdsaW5nICZsdDt6ZW5naG9uZ2xpbmdAa3lsaW5vcy5jbiZn
dDsgJmd0OyAtLS0gJmd0OyBkcml2ZXJzL3ZpZGVvL2ZiZGV2L29tYXAyL29t
YXBmYi9vbWFwZmItbWFpbi5jIHwgMiArLSAmZ3Q7IDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKSBhcHBsaWVkLiBQUzog
SSByZXBsYWNlZCBhdXRob3IvZW1haWwgbmFtZSBieSAiSG9uZ2xpbmcgWmVu
ZyIgaW5zdGVhZCBvZiAiemVuZ2hvbmdsaW5nIi4gSSBhc3N1bWUgdGhhdCdz
IE9rLCBpZiBub3QgcGxlYXNlIGxldCBtZSBrbm93LiBUaGFua3MhIEhlbGdl
ICZsdDsvemVuZ2hvbmdsaW5nQGt5bGlub3MuY24mZ3Q7Jmx0Oy9sa3BAaW50
ZWwuY29tJmd0OzwvZGl2Pgo8L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8cD4mbmJz
cDs8L3A+CjxkaXYgaWQ9InNpZ25hdHVyZUJvbSI+CjxkaXY+CjxwPiZuYnNw
OzwvcD4KPGJyPgo8cCBzdHlsZT0iY29sb3I6ICMwMDA7IGZvbnQtc2l6ZTog
MTZweDsiPi0tLTwvcD4KPGRpdiBpZD0iY3MyY19tYWlsX3NpZ2F0dXJlIiBz
dHlsZT0iY29sb3I6ICMwMDA7IGZvbnQtc2l6ZTogMTZweDsgZm9udC1mYW1p
bHk6IE1pY3Jvc29mdCBZYUhlaTsiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+Cjwv
ZGl2Pgo8L2Rpdj48L2Rpdj4=

--nsmail-6t35ut7s8ime-6t3a3xxuelvr--
