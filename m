From: "=?UTF-8?Q?Lu=C3=ADs_Cargnini?=" <lvcargnini@gmail.com>
Subject: reading MCBSP, pollread returning error
Date: Wed, 7 Nov 2007 02:37:36 -0200
Message-ID: <ae36f8040711062037l3c40b18cib9b09dfa96e25349@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0319940876=="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--===============0319940876==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

RGVhciBGZWxsb3dzLApJJ20gcmVhZGluZyBhbiBBRCBjb25uZWN0ZWQgdGhyb3cgTWNCU1AyLCBj
b25maWd1cmVkIGFzIGZvbGxvdzoKICAgICAgICAuc3BjcjEgPSBSUkRZIHwgUklOVE0oMCkgfCBS
UlNULAogICAgICAgIC5zcGNyMiA9IFhSRFkgfCBGUkVFIHwgU09GVCB8IEZSU1QgfCBHUlNUIHwg
WElOVE0oMCkgfCBYRU1QVFksCiAgICAgICAgLnJjcjEgID0gUkZSTEVOMShPTUFQX01DQlNQX1dP
UkRfMTYpIHwgUldETEVOMShPTUFQX01DQlNQX1dPUkRfMTYpLAogICAgICAgIC5yY3IyICA9IFJG
UkxFTjIoT01BUF9NQ0JTUF9XT1JEXzE2KSB8IFJXRExFTjIoT01BUF9NQ0JTUF9XT1JEXzE2KSB8
ClJEQVRETFkoMCksCiAgICAgICAgLnhjcjEgID0gWEZSTEVOMShPTUFQX01DQlNQX1dPUkRfOCkg
fCBYV0RMRU4xKE9NQVBfTUNCU1BfV09SRF8xNiksCiAgICAgICAgLnhjcjIgID0gWEZSTEVOMihP
TUFQX01DQlNQX1dPUkRfMTYpIHwgWFdETEVOMihPTUFQX01DQlNQX1dPUkRfMTYpIHwKWERBVERM
WSgwKSwKICAgICAgICAuc3JncjEgPSBDTEtHRFYoMjAwKSB8IEZXSUQoREVGQVVMVF9CSVRfU0FN
UExFUkFURS0xKSwvKiBtb2RpZmljYXIgZQpjb2xvY2FyIHVtIGRlZmF1bHQgKi8KICAgICAgICAu
c3JncjIgPSBDTEtTTSB8IEZQRVIoMipERUZBVUxUX0JJVF9TQU1QTEVSQVRFLTEpLAogICAgICAg
IC8qIFNsYXZlIENMS1hQIHwgQ0xLUlAsICovCiAgICAgICAgLnBjcjAgID0gRlNYTSB8IEZTUk0g
fCBDTEtYTSB8IENMS1JNLCAvKiBNYXN0ZXIgKi8KCndoZW4gSSB0cnkgdG8gcmVhZCB0aGUgQUQg
KEFEUzgzNDNCKQp0aGUgcG9sbF9yZWFkIHJldHVybiAtMQoKdGhlIHJlY3Zfd29yZCBmdW5jdGlv
biBnZXQgbG9ja2VkIGluIHdhaXRfY29tcGxldGlvbiwKU29tZW9uZSBrbm93cyBzb21ldGhpbmcg
YWJvdXQgdGhpcyBraW5kIG9mIGVycm9yID8KCi0tIAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhh
bmtzICYmIFJlZ2FyZHMKTXNjLiBCc2MuIEx1w61zIFZpdMOzcmlvIENhcmduaW5pCklFRUUgTWVt
YmVyCkVsZWN0cmljYWwgRW5naW5lZXIgRmFjdWx0eSBAIFBVQ1JTCklwaXJhbmdhIEF2ZW51ZSwg
NjY4MSDigJMgQnVpbGRpbmcgMzAKUC5PLiBCb3g6IDkwNjE5LTkwMCDigJMgUG9ydG8gQWxlZ3Jl
L1JTClBob25lOiArNTUgNTEgMzMyMCAzNTAwICBleHRlbnNpb246IDc2OTYKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCg==
--===============0319940876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0319940876==--
