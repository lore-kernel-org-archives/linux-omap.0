From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next 3/3] net: ethernet: ti: cpsw: add XDP
 support
Date: Mon, 27 May 2019 10:17:23 +0300
Message-ID: <20190527071723.GE24680@kadam>
References: <20190523182035.9283-4-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <20190523182035.9283-4-ivan.khoronzhuk@linaro.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org
Cc: xdp-newbies@vger.kernel.org, grygorii.strashko@ti.com, jakub.kicinski@netronome.com, hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, ilias.apalodimas@linaro.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, ast@kernel.org, kbuild-all@01.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, linux-omap@vger.kernel.org, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

Hi Ivan,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Ivan-Khoronzhuk/net-ethernet-ti-cpsw-Add-XDP-support/20190524-114123

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/ti/cpsw_ethtool.c:564 cpsw_xdp_rxq_reg() error: uninitialized symbol 'ret'.

# https://github.com/0day-ci/linux/commit/3cf4eb125ed19d18340fd3b0c4d7eb2f1ebdfb28
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 3cf4eb125ed19d18340fd3b0c4d7eb2f1ebdfb28
vim +/ret +564 drivers/net/ethernet/ti/cpsw_ethtool.c

c24eef28 Grygorii Strashko 2019-04-26  534  
3cf4eb12 Ivan Khoronzhuk   2019-05-23  535  static int cpsw_xdp_rxq_reg(struct cpsw_common *cpsw, int ch)
3cf4eb12 Ivan Khoronzhuk   2019-05-23  536  {
3cf4eb12 Ivan Khoronzhuk   2019-05-23  537  	struct cpsw_slave *slave;
3cf4eb12 Ivan Khoronzhuk   2019-05-23  538  	struct cpsw_priv *priv;
3cf4eb12 Ivan Khoronzhuk   2019-05-23  539  	int i, ret;
3cf4eb12 Ivan Khoronzhuk   2019-05-23  540  
3cf4eb12 Ivan Khoronzhuk   2019-05-23  541  	/* As channels are common for both ports sharing same queues, xdp_rxq
3cf4eb12 Ivan Khoronzhuk   2019-05-23  542  	 * information also becomes shared and used by every packet on this
3cf4eb12 Ivan Khoronzhuk   2019-05-23  543  	 * channel. But exch xdp_rxq holds link on netdev, which by the theory
3cf4eb12 Ivan Khoronzhuk   2019-05-23  544  	 * can have different memory model and so, network device must hold it's
3cf4eb12 Ivan Khoronzhuk   2019-05-23  545  	 * own set of rxq and thus both netdevs should be prepared
3cf4eb12 Ivan Khoronzhuk   2019-05-23  546  	 */
3cf4eb12 Ivan Khoronzhuk   2019-05-23  547  	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
3cf4eb12 Ivan Khoronzhuk   2019-05-23  548  		if (!slave->ndev)
3cf4eb12 Ivan Khoronzhuk   2019-05-23  549  			continue;

Smatch always complains that every loop iteration could continue.  Or
that cpsw->data.slaves might be zero at the start...  It seems
implausible.

3cf4eb12 Ivan Khoronzhuk   2019-05-23  550  
3cf4eb12 Ivan Khoronzhuk   2019-05-23  551  		priv = netdev_priv(slave->ndev);
3cf4eb12 Ivan Khoronzhuk   2019-05-23  552  
3cf4eb12 Ivan Khoronzhuk   2019-05-23  553  		ret = xdp_rxq_info_reg(&priv->xdp_rxq[ch], priv->ndev, ch);
3cf4eb12 Ivan Khoronzhuk   2019-05-23  554  		if (ret)
3cf4eb12 Ivan Khoronzhuk   2019-05-23  555  			goto err;
3cf4eb12 Ivan Khoronzhuk   2019-05-23  556  
3cf4eb12 Ivan Khoronzhuk   2019-05-23  557  		ret = xdp_rxq_info_reg_mem_model(&priv->xdp_rxq[ch],
3cf4eb12 Ivan Khoronzhuk   2019-05-23  558  						 MEM_TYPE_PAGE_POOL,
3cf4eb12 Ivan Khoronzhuk   2019-05-23  559  						 cpsw->rx_page_pool);
3cf4eb12 Ivan Khoronzhuk   2019-05-23  560  		if (ret)
3cf4eb12 Ivan Khoronzhuk   2019-05-23  561  			goto err;
3cf4eb12 Ivan Khoronzhuk   2019-05-23  562  	}
3cf4eb12 Ivan Khoronzhuk   2019-05-23  563  
3cf4eb12 Ivan Khoronzhuk   2019-05-23 @564  	return ret;

This would be more readable as "return 0;" anyway.

3cf4eb12 Ivan Khoronzhuk   2019-05-23  565  
3cf4eb12 Ivan Khoronzhuk   2019-05-23  566  err:
3cf4eb12 Ivan Khoronzhuk   2019-05-23  567  	cpsw_xdp_rxq_unreg(cpsw, ch);
3cf4eb12 Ivan Khoronzhuk   2019-05-23  568  	return ret;
3cf4eb12 Ivan Khoronzhuk   2019-05-23  569  }
