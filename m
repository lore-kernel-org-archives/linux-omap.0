From: Paul Walmsley <paul@booyaka.com>
Subject: Re: new PRCM breakage: 2430 FB
Date: Wed, 13 Jun 2007 13:00:35 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0706131259150.26500@utopia.booyaka.com>
References: <46675138.80205@mvista.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="155748971-1990801805-1181761235=:26500"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46675138.80205@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1990801805-1181761235=:26500
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Wed, 6 Jun 2007, Kevin Hilman wrote:

> I just noticed that with the new PRCM reorg, the 2430 LCD is no longer
> powering on.  I'll dig into it tomorrow, but any pointers would be
> appreciated.

Hi Kevin,

I think I may have found the problem.  Could you give the attached patch a 
test?

thanks,

- Paul
--155748971-1990801805-1181761235=:26500
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=fix-dss_54m_fck-bug.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0706131300350.26500@utopia.booyaka.com>
Content-Description: 
Content-Disposition: attachment; filename=fix-dss_54m_fck-bug.patch

LS0tDQogYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9jay5oIHwgICAgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KDQpJbmRleDogbGludXgtb21hcC9hcmNoL2FybS9tYWNoLW9tYXAyL2Ns
b2NrLmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC1vbWFw
Lm9yaWcvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9jay5oDQorKysgbGludXgt
b21hcC9hcmNoL2FybS9tYWNoLW9tYXAyL2Nsb2NrLmgNCkBAIC0xMDcxLDcg
KzEwNzEsNyBAQCBzdGF0aWMgc3RydWN0IGNsayBkc3NfNTRtX2ZjayA9IHsJ
LyogQWx0DQogCS5mbGFncwkJPSBDTE9DS19JTl9PTUFQMjQyWCB8IENMT0NL
X0lOX09NQVAyNDNYIHwNCiAJCQkJUkFURV9GSVhFRCB8IFJBVEVfUFJPUEFH
QVRFUywNCiAJLmVuYWJsZV9yZWcJPSBPTUFQX0NNX1JFR0FERFIoQ09SRV9N
T0QsIENNX0ZDTEtFTjEpLA0KLQkuZW5hYmxlX2JpdAk9IE9NQVAyNFhYX0VO
X0RTUzJfU0hJRlQsDQorCS5lbmFibGVfYml0CT0gT01BUDI0WFhfRU5fVFZf
U0hJRlQsDQogCS5yZWNhbGMJCT0gJm9tYXAyX3Byb3BhZ2F0ZV9yYXRlLA0K
IH07DQogDQo=

--155748971-1990801805-1181761235=:26500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-1990801805-1181761235=:26500--
