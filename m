From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
Date: Fri, 22 Dec 2006 05:57:31 +0000 (GMT)
Message-ID: <17512019.399221166767051091.JavaMail.weblogic@ep_ml29>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1461604702=="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--===============1461604702==
Content-return: prohibited
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: base64

DQo+IFllYWgsIEkgYmVsaWV2ZSB0aGUgb21hcCBsZXZlbCBncGlvcyBzaG91bGQgd29yayBmaW5l
IHRvby4gS3l1bmdtaW4sDQo+IGRvIHlvdSBoYXZlIHNvbWUgc3BlY2lhbCBpbnRlcnJ1cHQgcm91
dGluZyBmb3IgeW91ciBzbWM5MXg/IE9yIGRvIHlvdQ0KPiBzZWUgdGhpcyBvbmx5IHdpdGggdGhl
IFJUIHBhdGNoZXMgYXBwbGllZD8NCg0KWWVzIEl0J3MgcHJvYmxlbSBvbiBvbmx5IFJUIGVudmly
b25tZW50Lg0KQnV0IEkgdGhpbmsgaXQncyBzYWZlIHRvIHNldCBJUlFGX1RSSUdHRVJfUklTSU5H
IGluc3RlYWQgb2YgSVJRRl9UUklHR0VSX0hJR0guIGV2ZW4gdGhvdWdoIGl0IGlzIGxldmVsLXNl
bnNpdmUuDQoNClRoYW5rIHlvdSwNCkt5dW5nbWluIFBhcmsNCg0KDQoNCg==



--===============1461604702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1461604702==--
