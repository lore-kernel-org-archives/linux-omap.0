From: "Menon, Nishanth" <nm@ti.com>
Subject: dma_alloc_coherent fragmentation
Date: Tue, 17 Mar 2009 01:16:55 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF5A49A8@dlee02.ent.ti.com>
References: <87sklh1ki5.fsf@deeprootsystems.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD141D@dbde02.ent.ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A4274@dlee02.ent.ti.com>
 <269694c00903161029x37c44fe8q9e550b7b81b01913@mail.gmail.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF5A46E5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46955 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbZCQGRO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2009 02:17:14 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF5A46E5@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Ameya Palande <2ameya@gmail.com>

TG9vcGluZyBpbiBsaW51eC1hcm0gTUw6DQoNCkRpc2N1c3Npb24gUmVmOiBbMV0obGludXgtb21h
cCBtYWlsaW5nIGxpc3QpDQpXaGlsZSB3b3JraW5nIHdpdGggTGludXggT01BUCBrZXJuZWxbMl0g
d2UgZm91bmQgdGhhdCBvbiBhbGxvY2F0aW5nIDQgbWVnIGNodW5rcyB1c2luZyBkbWFfYWxsb2Nf
Y29oZXJlbnQgYW5kIGRlLWFsbG9jYXRpbmcgd2l0aCBkbWFfZnJlZV9jb2hlcmVudCBpbiBhIGxv
b3AgdXNpbmcgYSB0ZXN0IGRyaXZlcls3XSwgdGhlIG1lbW9yeSBpcyBnZXR0aW5nIGZyYWdtZW50
ZWQgYXMgc2hvd24gYnkgQW1leWEncyBvYnNlcnZhdGlvbiBbM10gZmluYWxseSByZXN1bHRpbmcg
aW4gZHVtcF9zdGFjayBkdWUgdG8gbGFjayBvZiBwYWdlcy4NCg0KU2VhcmNoaW5nIHRocm91Z2gg
cHJldmlvdXMgYXJjaGl2ZXMsIGZvdW5kIFs0XSB3aGljaCBzZWVtIHRvIGltcGx5IHRoYXQgYWxs
b2NhdGluZyBjaHVua3MgZ3JlYXRlciB0aGFuIDEgcGFnZSBjb3VsZCBjYXVzZSBmcmFnbWVudGF0
aW9uLg0KDQpJIHdvbmRlciB3aHkgd2Ugc2VlIHRoaXMgZXZlbiBpZiB3ZSBhbGxvY2F0ZSBhbmQg
ZnJlZSB0aGUgbWVtb3J5IGluIHNlcXVlbmNlIGFzIGluIFs1XS4gVGhpcyBzZWVtcyB0byBoYXBw
ZW4gb24gMi42LjI4IGFuZCAyLjYuMjkgYnV0IG5vdCBvbiB0aGUgMi42LjI3IGJhc2VkIGtlcm5l
bFs2XS4NCg0KUmVnYXJkcywNCk5pc2hhbnRoIE1lbm9uDQoNClJlZjoNClsxXSBodHRwOi8vbWFy
Yy5pbmZvLz90PTEyMzcxOTc3OTEwMDAwMiZyPTEmdz0yDQpbMl0gaHR0cDovL2dpdC5rZXJuZWwu
b3JnLz9wPWxpbnV4L2tlcm5lbC9naXQvdG1saW5kL2xpbnV4LW9tYXAtMi42LmdpdA0KWzNdIGh0
dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtb21hcCZtPTEyMzcyMjQ2MDAyMjMzNiZ3PTINCls0XSBo
dHRwOi8vbGttbC5pbmRpYW5hLmVkdS9oeXBlcm1haWwvbGludXgva2VybmVsLzA3MDYuMC8wMzcw
Lmh0bWwgDQpbNV0gaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1vbWFwJm09MTIzNzE5NzcyODEx
NzQ2Jnc9Mg0KWzZdIGh0dHA6Ly9naXQub21hcHpvb20uY29tLz9wPXJlcG8vb21hcGtlcm5lbC5n
aXQ7DQpbN10gaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1vbWFwJm09MTIzNzE5NzcyODExNzQ2
JnE9cDMgDQo=
