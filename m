From: "Liu, Jason" <jason.liu@spansion.com>
Subject: A uboot problem when booting from on-board NOR Flash on H4 platform
Date: Thu, 5 Jan 2006 16:37:26 +0800
Message-ID: <CC04AFA304B8774881AE87E8FEC6EF1868B271@ssuzexmb2.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685167340=="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

--===============0685167340==
Content-class: urn:content-classes:message
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: base64

DQpIaSBhbGwsDQoNCkkgbWV0IGFuIGlzc3VlIHdoZW4gYm9vdGluZyBhIGxpbnV4IGtlcm5lbCBm
cm9tIE5PUiBmbGFzaCBvbiBINCBNRU5FTEFVU0UgcGxhdGZvcm0uIHUtYm9vdCBmb3IgaDQgaXMg
ZG93bmxvYWRlZCBmcm9tIGxpbnV4Lm9tYXAuY29tLiBOb3RoaW5nIGlzIG1vZGlmaWVkIGV4Y2Vw
dCB0aGF0IHRoZSBDRkdfTkFORF9CT09UIGlzIHVuZGVmaW5lZC4NCg0KDQpUaGUgbGludXgga2Vy
bmVsIGNhbiBiZSBib290ZWQgZnJvbSBSQU0gaWYgd2UgdXNlIHRoZSBiZWxvdyB1Ym9vdCBjb21t
YW5kLA0KPiB0ZnRwYm9vdCAweDgwMDA3ZmMwIHVJbWFnZSAgIA0KPiBib290bSAweDgwMDA3ZmMw
DQovL05vdGU6IHVJbWFnZSBpcyBnZW5lcmF0ZWQgZnJvbSBta2ltYWdlLCAibWtpbWFnZSAtQSBh
cm0gLU8gbGludXggLVQga2VybmVsIC1DIG5vbmUgLWEgMHg4MDAwN2ZjMCAtZSAweDgwMDA4MDAw
IC1uICJMaW51eCBJbWFnZSIgLWQgbGludXguYmluIHVJbWFnZSINCg0KLi4uLi4uLktlcm5lbCBi
b290aW5nIE9LISENCg0KDQpCdXQgbm93LCBJIHdhbnQgdG8gYm9vdCB0aGUgdUltYWdlIGZyb20g
Tk9SIEZsYXNoLCAgSSB1c2UgdGhlIGZvbGxvd2luZyB1Ym9vdCBjb21tYW5kIHRvIGZsYXNoIHRo
ZSBOT1IgZmxhc2ggZmlyc3RseSwNCj4gcHJvdGVjdCBvZmYgYWxsDQo+IGVyYXNlIDE6OC0yMyAg
ICAvKiBJbnRlbCBGbGFzaCB3aXRoIDEyOGtCIHBlciBzZWN0b3IsZXJhc2UgMk1CIGZyb20gdGhl
IGJlZ2lubmluZyBvZiAweDA0MTAwMDAwKi8NCj4gdGZ0cGJvb3QgMHg4MDAwN2ZjMCB1SW1hZ2UN
Cj4gY3AgMHg4MDAwN2ZjMCAweDA0MTAwMDAwIDB4MjAwMDAwICAgLyogMk0gc2l6ZSBmb3Iga2Vy
bmVsICovDQovL05vdGU6IHVJbWFnZSBpcyBnZW5lcmF0ZWQgZnJvbSBta2ltYWdlLCAibWtpbWFn
ZSAtQSBhcm0gLU8gbGludXggLVQga2VybmVsIC1DIG5vbmUgLWEgMHgwNDEwMDAwMCAtZSAweDA0
MTAwMDQwIC1uICJMaW51eCBJbWFnZSIgLWQgbGludXguYmluIHVJbWFnZSINCg0KQWZ0ZXIgZmxh
c2hpbmcgaXMgb3ZlciwgSSBib290IHRoZSBrZXJuZWwgd2l0aCB0aGUgYmVsb3cgY29tbWFuZDoN
Cj4gYm9vdG0gMHgwNDEwMDAwMA0KDQpUaGUgdGVybWluYWwgc2hvd3MgdGhlIGJlbG93IGluZm9y
bWF0aW9uOg0KDQojIyBCb290aW5nIGltYWdlIGF0IDA0MTAwMDAwIC4uLg0KICAgSW1hZ2UgTmFt
ZTogICBCaWxsIExpbnV4IEltYWdlDQogICBJbWFnZSBUeXBlOiAgIEFSTSBMaW51eCBLZXJuZWwg
SW1hZ2UgKHVuY29tcHJlc3NlZCkNCiAgIERhdGEgU2l6ZTogICAgMTk3NTg3MiBCeXRlcyA9ICAx
LjkgTUINCiAgIExvYWQgQWRkcmVzczogMDQxMDAwMDANCiAgIEVudHJ5IFBvaW50OiAgMDQxMDAw
NDANCiAgIFZlcmlmeWluZyBDaGVja3N1bSAuLi4gT0sNCiAgIFhJUCBLZXJuZWwgSW1hZ2UgLi4u
IE9LDQoNClN0YXJ0aW5nIGtlcm5lbCAuLi4NCg0KVGhlbiBzdG9wcGVkLCBhbmQgZm9sbG93ZWQg
Ynkgbm90aGluZy4uLi4uLjooDQoNClNvLCBjb3VsZCBhbnlib2R5IHRlbGwgbWUgd2hhdCB0aGUg
cmVhc29uIGlzPyAgb3IgdGVsbCBtZSBhbm90aGVyIHdheSB0byBmdWxmaWxsIGl0LiBUaGFua3Mg
YSBsb3QhISENCg0KDQpKYXNvbiBMaXUgIA0KDQoNCg0KDQoNCg0KDQoNCiANCmFuIGlzc3VlIHdo
ZW4gYm9vdGluZyBhIGxpbnV4IGtlcm5lbCBmcm9tIE5PUiBmbGFzaC4NClRoZSBsaW51eCBrZXJu
ZWwgDQoNCg0KSmFzb24gTGl1DQoNCg==

--===============0685167340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0685167340==--
