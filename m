From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] Disable old OMAP RTC driver if RTC_DRV_OMAP is enabled
Date: Mon, 4 Jun 2007 16:20:24 +0200
Message-ID: <fb249edb0706040720t13ff9bfan8c31b2083959f7a3@mail.gmail.com>
References: <fb249edb0706040718g14b6fc80r7d3c28204dbe53e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2488_32712808.1180966824808"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0706040718g14b6fc80r7d3c28204dbe53e8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_2488_32712808.1180966824808
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This time with the actual change.

On 04/06/07, andrzej zaborowski <balrogg@gmail.com> wrote:
> Make the old RTC driver depend on !RTC_DRV_OMAP to avoid conflicts. It
> makes the new driver in rtc class take precedence over the old one.
>
> What's the status of the OMAP RTC in Character Devices?  Is it going
> to be removed? Enabling both drivers results in an Oops on boot due to
> name collision.
>
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_2488_32712808.1180966824808
Content-Type: text/plain;
	name=0004-Disable-old-OMAP-RTC-driver-if-DRV_RTC_OMAP-is-enabled.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2j39xhd
Content-Disposition: attachment;
	filename="0004-Disable-old-OMAP-RTC-driver-if-DRV_RTC_OMAP-is-enabled.txt"

RnJvbSA5OGQ1YTk0NmY5M2E0ZWFkMmFjYmNlMjNmMWVlMmNkYjgwYzI0Yzk2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGJhbHJvZ0B6YWJvci5vcmc+
CkRhdGU6IE1vbiwgNCBKdW4gMjAwNyAxNzoxMTowNiArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIERp
c2FibGUgb2xkIE9NQVAgUlRDIGRyaXZlciBpZiBEUlZfUlRDX09NQVAgaXMgZW5hYmxlZC4KCi0t
LQogZHJpdmVycy9jaGFyL0tjb25maWcgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvS2Nv
bmZpZyBiL2RyaXZlcnMvY2hhci9LY29uZmlnCmluZGV4IDhkZDM0NzUuLmQzZWJmNzUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvY2hhci9LY29uZmlnCisrKyBiL2RyaXZlcnMvY2hhci9LY29uZmlnCkBA
IC04NDMsNyArODQzLDcgQEAgY29uZmlnIEVGSV9SVEMKIAlkZXBlbmRzIG9uIElBNjQKIGNvbmZp
ZyBPTUFQX1JUQwogCWJvb2wgIlRJIE9NQVAgUmVhbCBUaW1lIENsb2NrIgotCWRlcGVuZHMgb24g
QVJDSF9PTUFQMTVYWCB8fCBBUkNIX09NQVAxNlhYIHx8IEFSQ0hfT01BUDczMAorCWRlcGVuZHMg
b24gIVJUQ19EUlZfT01BUCAmJiAoQVJDSF9PTUFQMTVYWCB8fCBBUkNIX09NQVAxNlhYIHx8IEFS
Q0hfT01BUDczMCkKIAloZWxwCiAJICBTdXBwb3J0IGZvciBUSSBPTUFQIFJUQwogCi0tIAoxLjQu
NC4zCgo=
------=_Part_2488_32712808.1180966824808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_2488_32712808.1180966824808--
