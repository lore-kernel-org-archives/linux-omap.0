From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: SD response type 6 vs. 1
Date: Mon, 04 Jun 2007 14:56:59 -0400
Message-ID: <4664607B.1070103@indt.org.br>
References: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
	<466456CC.1070408@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060209040205050707080009"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <466456CC.1070408@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209040205050707080009
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ext Pierre Ossman wrote:
> andrzej zaborowski wrote:
>   
>> Hi,
>>  Linux has the same values for MMC_RSP_R1 and MMC_RSP_R6 thus making
>> the two response formats indistinguishable for mmc/sd hosts. Hardware
>> like my OMAP310 needs to know exactly whether to expect an R1 or R6
>> format, otherwise CMD3 fails.
>>
>> Sure it would be nice if it didn't care, but nevertheless, it's not a
>> hardware bug - the two formats are specified separately in SD specs
>> because they *are* different. So the hardware has full right to know
>> the right response type. Rather it's a hack to rely on R1 and R6
>> having the same size, like Linux does now. It would also be a hack to
>> allow the CMD3 to fail with CRC error and ignore the error, like
>> omap.c did before, because it makes an assumption that's not in the
>> OMAP specs.
>>     
>
> If you're referring to CERR, then I suggest you reread the specs. They
> even explicitly say its okay to ignore it.
>
> Anyway, I'm not going into this discussion again without a valid
> argument as to why the suggest path won't work.
>
>   
>> The following is an ugly fix. It's ugly because host code should be
>> agnostic to opcodes, as mentioned by Pierre Ossman.
>> I believe this was already submitted by Carlos Aguiar and rejected by
>> Pierre, which resulted in leaving the driver broken on some boards.
>>     
>
> This just hides the fact that the host parses the data more than we want
> and expect it to do.
>
>   
>> A more correct and more intrusive fix would look like this:
>>     
>
> Afraid not. The response type specifies format, not semantical contents.
>
> The correct fix has already been discussed, but I have seen zero
> attempts at implementing it:
>
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-April/009500.html
>
>   
Hi Pierre and andrzej,

Regarding the correct fix mentioned (and discussed) by Pierre, I'd
implemented a piece of this fix by removing CERR, but it's not enough to
make SD works. The patch find attached to this mail.

The part of be able to leave it out to do the card error parsing with
software, like Pierre said, must be implemented.

I'm now busy working in a patches series to MMC multislot support for
OMAP (1510, H2, H3 and H4) platforms.

Regards,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------060209040205050707080009
Content-Type: text/plain;
	name="0001-MMC-OMAP-Totally-remove-CERR-interrupt.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename="0001-MMC-OMAP-Totally-remove-CERR-interrupt.diff"

VG90YWxseSBkaXNhYmxlIG9mIENFUlIgaW50ZXJydXB0LCBieSBub3Qgd3JpdGluZyBPTUFQ
X01NQ19TVEFUX0NBUkRfRVJSCmJpdCB0byBJRSByZWdpc3RlciBhbmQgcmVtb3ZpbmcgT01B
UF9NTUNfU1RBVF9DQVJEX0VSUiBxdWlrcyBvbiBvbWFwLmMKClNpZ25lZC1vZmYtYnk6IENh
cmxvcyBFZHVhcmRvIEFndWlhciA8Y2FybG9zLmFndWlhckBpbmR0Lm9yZy5icj4KCkluZGV4
OiBsaW51eC1vbWFwL2RyaXZlcnMvbW1jL2hvc3Qvb21hcC5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4LW9tYXAub3JpZy9kcml2ZXJzL21tYy9ob3N0L29tYXAuYwkyMDA3LTA2LTA0IDE0
OjM3OjU2LjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtb21hcC9kcml2ZXJzL21tYy9ob3N0
L29tYXAuYwkyMDA3LTA2LTA0IDE0OjQ1OjQ5LjAwMDAwMDAwMCAtMDQwMApAQCAtMjUzLDgg
KzI1Myw3IEBAIG1tY19vbWFwX3N0YXJ0X2NvbW1hbmQoc3RydWN0IG1tY19vbWFwX2gKIAkJ
ICAgICAgIE9NQVBfTU1DX1NUQVRfQV9FTVBUWSAgICB8IE9NQVBfTU1DX1NUQVRfQV9GVUxM
ICAgIHwKIAkJICAgICAgIE9NQVBfTU1DX1NUQVRfQ01EX0NSQyAgICB8IE9NQVBfTU1DX1NU
QVRfQ01EX1RPVVQgIHwKIAkJICAgICAgIE9NQVBfTU1DX1NUQVRfREFUQV9DUkMgICB8IE9N
QVBfTU1DX1NUQVRfREFUQV9UT1VUIHwKLQkJICAgICAgIE9NQVBfTU1DX1NUQVRfRU5EX09G
X0NNRCB8IE9NQVBfTU1DX1NUQVRfQ0FSRF9FUlIgIHwKLQkJICAgICAgIE9NQVBfTU1DX1NU
QVRfRU5EX09GX0RBVEEpOworCQkgICAgICAgT01BUF9NTUNfU1RBVF9FTkRfT0ZfQ01EIHwg
T01BUF9NTUNfU1RBVF9FTkRfT0ZfREFUQSk7CiAJT01BUF9NTUNfV1JJVEUoaG9zdCwgQ01E
LCBjbWRyZWcpOwogfQogCkBAIC01MjMsMzEgKzUyMiw2IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dCBtbWNfb21hcF9pcnEoaW50IGlycSwKIAkJCQkJImNvbW1hbmQgQ1JDIGVycm9yIHdpdGhv
dXQgY21kP1xuIik7CiAJCX0KIAotCQlpZiAoc3RhdHVzICYgT01BUF9NTUNfU1RBVF9DQVJE
X0VSUikgewotCQkJaWYgKGhvc3QtPmNtZCAmJiBob3N0LT5jbWQtPm9wY29kZSA9PSBNTUNf
U1RPUF9UUkFOU01JU1NJT04pIHsKLQkJCQl1MzIgcmVzcG9uc2UgPSBPTUFQX01NQ19SRUFE
KGhvc3QsIFJTUDYpCi0JCQkJCXwgKE9NQVBfTU1DX1JFQUQoaG9zdCwgUlNQNykgPDwgMTYp
OwotCQkJCS8qIFNUT1Agc29tZXRpbWVzIHNldHMgbXVzdC1pZ25vcmUgYml0cyAqLwotCQkJ
CWlmICghKHJlc3BvbnNlICYgKFIxX0NDX0VSUk9SCi0JCQkJCQkJCXwgUjFfSUxMRUdBTF9D
T01NQU5ECi0JCQkJCQkJCXwgUjFfQ09NX0NSQ19FUlJPUikpKSB7Ci0JCQkJCWVuZF9jb21t
YW5kID0gMTsKLQkJCQkJY29udGludWU7Ci0JCQkJfQotCQkJfQotCi0JCQlkZXZfZGJnKG1t
Y19kZXYoaG9zdC0+bW1jKSwgImNhcmQgc3RhdHVzIGVycm9yIChDTUQlZClcbiIsCi0JCQkJ
aG9zdC0+Y21kLT5vcGNvZGUpOwotCQkJaWYgKGhvc3QtPmNtZCkgewotCQkJCWhvc3QtPmNt
ZC0+ZXJyb3IgPSBNTUNfRVJSX0ZBSUxFRDsKLQkJCQllbmRfY29tbWFuZCA9IDE7Ci0JCQl9
Ci0JCQlpZiAoaG9zdC0+ZGF0YSkgewotCQkJCWhvc3QtPmRhdGEtPmVycm9yID0gTU1DX0VS
Ul9GQUlMRUQ7Ci0JCQkJdHJhbnNmZXJfZXJyb3IgPSAxOwotCQkJfQotCQl9Ci0KIAkJLyoK
IAkJICogTk9URTogT24gMTYxMCB0aGUgRU5EX09GX0NNRCBtYXkgY29tZSB0b28gZWFybHkg
d2hlbgogCQkgKiBzdGFydGluZyBhIHdyaXRlIAo=
--------------060209040205050707080009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060209040205050707080009--
